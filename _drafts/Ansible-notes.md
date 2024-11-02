---
title: Ansible notes
# date: 2024-04-07 00:00:01 -0400
categories: [automation, ansible]
tags: [automation, ansible]
author: dmcken
comments: false
---



## Install

While you can install ansible via your package manager this is highly discouraged because it tends to be very far behind the current stable version.

### venv:

I will defer to official docs for creation and setup of [venv](https://docs.python.org/3/library/venv.html).

```bash
pip install --include-deps ansible argcomplete
```

Whenever you want to use ansible make sure you have activated the venv.

### pipx

I will defer to official docs for installation of [pipx](https://pipx.pypa.io/stable/).

```bash
pipx install --include-deps ansible argcomplete
```

### Confirming your install is working and checking version

```bash
ansible --version
```

The output should look like the following:
```bash
ansible [core 2.17.5]
  config file = None
  configured module search path = ['/home/ansible/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/ansible/.local/share/pipx/venvs/ansible/lib/python3.12/site-packages/ansible
  ansible collection location = /home/ansible/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/ansible/.local/bin/ansible
  python version = 3.12.3 (main, Sep 11 2024, 14:17:37) [GCC 13.2.0] (/home/ansible/.local/share/pipx/venvs/ansible/bin/python)
  jinja version = 3.1.4
  libyaml = True
```

If not then there is something wrong with your install (or you are not in your venv).

## Ad-hoc commands / basic setup

Check if you can connect to a machine via ssh

```bash
ansible all -i 192.168.1.11, -m ping -u <username> -k
ansible all -i 192.168.1.12, -m shell -a "who" -u admin -k
```


## Bare bones setup






# Random notes:


* https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html#ansible-pull
  * ansible-pull
  * Run playbooks
  * Check playbooks:
    * ansible-playbook --check playbook.yaml
* Mikrotik:
  * https://docs.ansible.com/ansible/latest/collections/community/routeros/api_modify_module.html#examples
  * https://docs.ansible.com/ansible/latest/collections/community/routeros/index.html
  * https://docs.ansible.com/ansible/latest/collections/community/routeros/docsite/api-guide.html
* https://www.ansible.com/ecosystem/?extIdCarryOver=true&sc_cid=701f2000001OH7YAAW
  * ansible-pylibssh
  * AWX
  * Collections
  * Core
    * Test
  * Lint
  * pytest
  * rulebook
  * runner
  * VS Code
* Non server related:
  * https://docs.ansible.com/ansible/latest/collections/index_cliconf.html - Cliconf (network devices)
* All collections
