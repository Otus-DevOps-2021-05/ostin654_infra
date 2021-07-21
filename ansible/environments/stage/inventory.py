#!/usr/bin/python3

import os
import sys
import json
import subprocess

if len(sys.argv) > 1 and sys.argv[1] == '--list':
    completed_process = subprocess.run(["terraform", "state", "pull"], capture_output=True, cwd="../terraform/stage")
    terraform_state = json.loads(completed_process.stdout)
    inventory = {"app": {"hosts": ["appserver"]}, "db": {"hosts": ["dbserver"]}, "_meta": {"hostvars": {"appserver": {"ansible_host": terraform_state["outputs"]["external_ip_address_app"]["value"], "db_host": terraform_state["outputs"]["internal_ip_address_db"]["value"]}, "dbserver": {"ansible_host": terraform_state["outputs"]["external_ip_address_db"]["value"]}}}}
    print(json.dumps(inventory))
