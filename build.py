#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.14"
# dependencies = ["pyyaml"]
# ///

import argparse
import subprocess
import sys
from pathlib import Path

import yaml


def parse_args():
    parser = argparse.ArgumentParser(description="Build podman images in order.")
    parser.add_argument(
        "--no-pull", action="store_true", help="Skip pulling base images."
    )
    parser.add_argument(
        "--no-push", action="store_true", help="Skip pushing built images."
    )
    parser.add_argument(
        "--no-cache", action="store_true", help="Build without layer cache."
    )
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "-d",
        "--image-dirs",
        nargs="+",
        metavar="IMAGE_DIR",
        help="Explicit list of image dirs to build.",
    )
    group.add_argument(
        "-y",
        "--yaml-image-dirs",
        default="images.yaml",
        metavar="YAML",
        help="Path to a YAML file (images.yaml by default) containing a list of image dirs.",
    )
    return parser.parse_args()


def _load_image_dirs(args) -> list[str]:
    if args.image_dirs:
        return args.image_dirs
    with Path(args.yaml_image_dirs).open(encoding="utf-8") as fin:
        dirs = yaml.safe_load(fin)
    if dirs is None:
        return []
    if not isinstance(dirs, list) or not all(isinstance(d, str) for d in dirs):
        raise ValueError(f"{args.yaml_image_dirs} must contain a YAML list of strings")
    return [s for d in dirs if (s := d.strip())]


def _parse_containerfile(image_dir: Path) -> list[str]:
    cf = image_dir / "Containerfile"
    images = []
    for line in cf.read_text().splitlines():
        upper = line.upper()
        if upper.startswith("FROM "):
            images.append(next(p for p in line.split()[1:] if not p.startswith("--")))
        elif upper.startswith("COPY --FROM="):
            images.append(line.split("=", 1)[1].split()[0])
    if not images:
        raise ValueError(f"Containerfile in {image_dir} is missing FROM")
    return images


def build_image(
    image_dir: str | Path,
    no_pull: bool,
    no_push: bool,
    no_cache: bool,
    images_built: set[str],
) -> str:
    if isinstance(image_dir, str):
        image_dir = Path(image_dir)
    image_dir = image_dir.resolve()
    dep_images = _parse_containerfile(image_dir)
    tag = f"quay.io/legendu/{image_dir.name}:next"

    if not no_pull:
        for dep in dep_images:
            if dep in images_built:
                continue
            result = subprocess.run(["podman", "pull", dep])
            if result.returncode != 0:
                sys.exit(result.returncode)

    build_cmd = ["podman", "build"]
    if no_cache:
        build_cmd.append("--no-cache")
    build_cmd += ["-t", tag, "."]
    result = subprocess.run(build_cmd, cwd=image_dir)
    if result.returncode != 0:
        sys.exit(result.returncode)

    if not no_push:
        result = subprocess.run(["podman", "push", tag])
        if result.returncode != 0:
            sys.exit(result.returncode)

    return tag


def main():
    args = parse_args()
    image_dirs = _load_image_dirs(args)
    images_built = set()

    for d in image_dirs:
        print(f"==> Building {d}")
        img = build_image(d, args.no_pull, args.no_push, args.no_cache, images_built)
        images_built.add(img)
        print()


if __name__ == "__main__":
    main()
