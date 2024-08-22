#!/usr/bin/env python3

import os
import subprocess

def init_keys():
    keys = ["bitbucket", "github", "salas", "mishim"]
    key_dir = os.path.expanduser("~/.ssh")

    # Create the directory if it doesn't exist
    os.makedirs(key_dir, exist_ok=True)

    for key in keys:
        key_path = os.path.join(key_dir, key)

        if not os.path.exists(key_path):
            subprocess.run(["ssh-keygen", "-t", "rsa", "-b", "4096", "-N", "", "-f", key_path])
        else:
            print(f"{key} key already exists.")

if __name__ == "__main__":
    init_keys()
