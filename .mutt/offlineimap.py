#!/usr/bin/python
import re, subprocess
def get_keychain_pass(account=None, server=None):
    params = {
        'security': '/usr/bin/security',
        'cmd': 'find-internet-password',
        'account': account,
        'server': server,
        'keychain': '$HOME/Library/Keychains/login.keychain',
    }
    command = "sudo -u $USER %(security)s -v %(cmd)s -a %(account)s -s %(server)s -g" % params
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    outtext = [l for l in output.splitlines()
               if l.startswith('password: ')][0]

    return re.match(r'password: "(.*)"', outtext).group(1)


