#!/usr/bin/python

# sourced from Issa Rice
# https://github.com/riceissa/dotfiles/blob/master/debian_packages.py

# This script installs some common tools used on a Debian-type systems. I
# comment or uncomment to select the programs I want to install. Since this
# script needs Python to run, I might necessarily `sudo aptitude
# install python` or `sudo apt-get install python` first.

from subprocess import call

def main():
    # Update sources and upgrade system
    call("sudo {apt_prog} update && sudo {apt_prog} upgrade".format(
        apt_prog=APT_PROG), shell=True)

    # Install programs
    call("sudo {apt_prog} install {programs}".format(
        apt_prog=APT_PROG, programs=' '.join(PROGRAMS)), shell=True)

# "apt-get" or "aptitude"
APT_PROG = "apt-get"

# List of programs to install
PROGRAMS = [
    # utilities
    "vim",
    "git",
    "htop",

    # advanced utilities
    "par", # alternative to fmt
    "gparted",
    "tree",

    # tmux and tiling windows
    "tmux",
]

if __name__ == "__main__":
    main()
