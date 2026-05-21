#!/usr/bin/env python3
#
# /// script
# requires-python = ">=3.14"
# dependencies = []
# ///

import argparse
import subprocess
import sys
from pathlib import Path


def parse_args():
    parser = argparse.ArgumentParser(
        description="Build images in order. Defaults to images.md in the script directory."
    )
    parser.add_argument(
        "--no-pull", action="store_true", help="Skip pulling base images"
    )
    parser.add_argument(
        "--no-push", action="store_true", help="Skip pushing built images"
    )
    parser.add_argument(
        "--no-cache", action="store_true", help="Build without layer cache"
    )
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "-d",
        "--image-dirs",
        nargs="+",
        metavar="IMAGE_DIR",
        help="Explicit list of image directories to build",
    )
    group.add_argument(
        "-f",
        "--file-image-dirs",
        default="images.md",
        metavar="FILE",
        help="File (images.md by default) containing image names (one per line).",
    )
    return parser.parse_args()


def _load_image_dirs(args) -> list[str]:
    if args.image_dirs:
        return args.image_dirs
    lines = Path(args.file_image_dirs).read_text().splitlines()
    lines = (line.strip() for line in lines)
    return [line for line in lines if line and not line.startswith("#")]


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
