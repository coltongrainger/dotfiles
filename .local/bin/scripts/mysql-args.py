#! /usr/bin/env python2
from subprocess import check_output

def get_pass():
    return check_output("gpg -dq /home/colton/.ssh/mysql-password.gpg", shell=True).decode().strip("\n")

print(get_pass())
