#!/usr/bin/python

# This script installs some common tools used on a Debian-type systems.
# Comment or uncomment to select the programs that you want to install.
# Since this script needs Python to run, it might be necessary to do
# (assuming you have sudo) `sudo aptitude install python` or `sudo
# apt-get install python` first.

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
    "emacs",
    "pandoc",
    "git",
    "htop",
    "elinks",

    "python3",
    "python-pip",
    "python3-pip",
    "python-dev", # headers for compiling python extensions 
    "python-gpgme", # maybe to encrypt emails?
    "gnupg",

    # email
    "mutt",
    "offlineimap",
    "notmuch",
    "msmtp",

    # news
    "newsbeuter",

    # website
    "ruby-sass", 

    # advanced utilities
    "surfraw", # for elinks
    "par", # alternative to fmt
    "detox", # for gross filenames
    "xclip",  
    "gparted",
    "moreutils", # contains sponge
    "tree",
    "lm-sensors", # check temperature
    "keepassx",
    "duplicity",

    # tmux and tiling windows
    "tmux",
    "xmonad",

    # programming-related
    "build-essential",
    "exuberant-ctags",
    "gcc",
    "cmake",
    r"g\+\+",
    "ruby-full",

    # see issarice.com/installing-haskell
    "ghc",
    "ghc-prof",
    "libghc-zlib-dev",

    # music on console 
    "moc",                 # Run using 'mocp'.
    "moc-ffmpeg-plugin",   # Extra plugins.

    # LaTeX (warning: large download)
    "texlive-full",
    "fonts-linuxlibertine",
    "fonts-lato",

    # media related tools
    "flac",
    "vlc",
    "vorbis-tools",
]

if __name__ == "__main__":
    main()
