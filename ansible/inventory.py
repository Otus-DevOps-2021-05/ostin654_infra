#!/usr/bin/python

import sys

if len(sys.argv) > 1 and sys.argv[1] == '--list':
    with open('inventory.json', 'r') as file:
        print file.read()
