#! /usr/bin/env python2
from subprocess import check_output

def get_pass():
        return check_output("cat ~/.gmail-app-pass", shell=True).strip("\n")
