# Podman Container Images |  [@GitHub](https://github.com/legendu-net/podman)

The collection of podman Containerfiles for building images [quay.io/legendu/*](https://quay.io/user/legendu/).
See
[My Podman Container Images](https://www.legendu.net/drafts/2026/05/my-podman-container-images)
on understanding and using those container images.

## Building Images

Use `build.py` to build images. It builds each image directory in order,
tagging the result as `quay.io/legendu/<dir_name>:next`.

`./build.py` builds all images specified in `images.yaml`
(override with `-y`/`--yaml-image-dirs`) in the listed order,
so that each image is built after the images it depends on.

To build a specific directory, pass it via `-d`/`--image-dirs`.

```bash
./build.py -d jupyterlab
```

You can also build from inside the directory itself using `.`.

```bash
cd jupyterlab
../build.py -d .
```

Both commands produce the same image (`quay.io/legendu/jupyterlab:next`),
since the directory path is resolved to its real name before tagging.

Useful flags:

- `--no-pull`: skip pulling base images.
- `--no-push`: skip pushing built images.
- `--no-cache`: build without layer cache.

