#!/usr/bin/env python3
# /// script
# requires-python = ">=3.12"
# ///
import subprocess as sp


def get_jupyter_user() -> bytes:
    cmd = "ps aux | grep -i -E 'python3 .*jupyter(-lab)?'"
    # capture stout but keep stderr visible
    proc = sp.run(cmd, shell=True, stdout=sp.PIPE, check=False)
    for line in proc.stdout.strip().split(b"\n"):
        if b"/opt/venv/bin/python3 /opt/venv/bin/jupyter" in line:
            return line.strip().split()[0]
        if b"/usr/bin/python3 /usr/local/bin/jupyter" in line:
            return line.strip().split()[0]
    raise ProcessLookupError("No process named jupyter or jupyter-lab.")


def main():
    cmd = ["/scripts/list_jupyter.py"]
    sp.run(cmd, check=True)


if __name__ == "__main__":
    main()
