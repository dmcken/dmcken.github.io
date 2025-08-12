---
title: Ansible notes
date: 2025-01-05 00:00:01 -0400
categories: [automation, ansible]
tags: [automation, ansible]
author: dmcken
comments: false
---



## Install

While you can install ansible via your package manager this is highly discouraged because it tends to be very far behind the current stable version. As such I recommend one of the following:

### Standard venv

I will defer to official docs for creation and setup of [venv](https://docs.python.org/3/library/venv.html). Once setup and entered

```bash
# Base install
pip install --include-deps ansible argcomplete

# Common addons
pip install --include-deps passlib
pip install --include-deps paramiko
pip install --include-deps ansible-pylibssh
```

Whenever you want to use ansible make sure you have activated the venv.

### pipx

I will defer to official docs for installation of [pipx](https://pipx.pypa.io/stable/). Once installed you can install ansible with some useful optional dependencies with the following:

```bash
# Base install
pipx install --include-deps ansible

# Common Addons
pipx inject ansible passlib
pipx inject ansible paramiko
pipx inject ansible ansible-pylibssh
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

Check if you can connect to a machine via ssh.

```bash
ansible all -i 192.168.1.11, -m ping -u <username> -k
```

or

```bash
ansible all -i 192.168.1.12, -m shell -a "who" -u admin -k
```

These only work for *NIX-style shells with the appropriate commands. Restricted shells (especially those of routers or other embedded systems) will likely not work.

### Single task playbook to command

Take a single task playbook to a single command line (i.e. use `ansible` vs `ansible-playbook`).

```yaml
{% raw %}
---
- name Setup users
  hosts all
  become true
  tasks
    - name add user hybrid
      ansible.builtin.user
        name hybrid
        password {{ 'acctpassword'  password_hash('sha512') }}
        groups
          - sudo
        state present
        create_home true
        shell binbash
        update_password on_create
{% endraw %}
```

## Mikrotik RouterOS

### Pre-requisites

The current

```bash
pipx inject ansible ansible-dev-tools --include-apps
pipx inject ansible ansible-lint --include-apps
pipx inject ansible argcomplete
pipx inject ansible librouteros
```

### Ad-hoc command

Connects to:
* host:
  * Inventory: -i 192.168.1.12,
  * All hosts in the inventory
* username: -u admin
* Ask for passsword at rumtime (-k)
* Use the routeros community plugin
* Run the network_cli function
* Run the command: "/ip/address/print"

```bash
ansible all -i 192.168.1.11,192.168.1.12 -u admin -k \
    -e ansible_network_os=community.routeros.routeros \
    -e ansible_connection=ansible.netcommon.network_cli \
    -m community.routeros.command -a "commands=/ip/address/print"
```

Or if you want to use a re-usable inventory file:

```
[routers]
rtr_bedroom     ansible_host=192.168.1.12
rtr_livingroom  ansible_host=192.168.1.11

[routers:vars]
ansible_connection=ansible.netcommon.network_cli
ansible_network_os=community.routeros.routeros
ansible_user=admin
ansible_ssh_pass=password123
```

Obviously change the user and ssh_pass to your appropriate values.

Your command line now becomes:
```bash
ansible routers -i hosts -m community.routeros.command -a "commands=/ip/address/print"
```

Testing connectivity can also be done with:
```bash
ansible routers -i hosts -m community.routeros.facts
```

## Netbox inventory

Goals:
* Use netbox to provide the inventory data (hosts list)
  * Filtered by platforms primarily (playbooks for routers cannot be used against servers and vice-versa).
* Use tags on device to flag groups of



Fixing conflicting names:
* https://github.com/netbox-community/ansible_modules/issues/1272



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
* Modules:
  * Network:
    * cli
    * files
      * net_get
      * net_put
    * interface
    * layer2
    * layer3
    * netconf
    * protocol
      * net_lldp
    * Routing
      * net_static_route
    * Restconf
    * System
      * net_banner
      * net_logging
      * net_ping
      * net_system
      * net_user
    * Edgeos     - Edge Router
    * Edgeswitch - Edge Switch
    * Frr        - FRR routing
    * Junos      - Juniper
    * Ovs        - Open vSwitch
    * Panos      - PAN-OS
    * Routeros   - Mikrotik
    * Vyos       - VyOS
  * Cloud
    * Digital Ocean
    * Docker
    * Google     - GCP
    * Kubevirt
    * Lxc
    * Misc:
      * helm     - k8s helm
      * proxmox  - General proxmox
      * proxmox_kvm
      * proxmox_template
      * terraform
      * virt
      * virt_net
      * virt_pool
    * Podman
    * Xenserver
  * Clustering:
    * etcd3
    * K8S        - Kubernetes
    * pacemaker_cluster
    * ZooKeeper
  * Command:
    * command
    * expect
    * raw
    * script
    * shell
    * telnet
  * Crypto:
    * get_certificate
    * openssh_cert
    * openssh_keypair
    * openssl_*
    * acme_*
  * Database:
    * Influxdb
    * Mysql
    * Postgresql
  * Files:
    * archive – Creates a compressed archive of one or more files or trees
    * assemble – Assemble configuration files from fragments
    * blockinfile – Insert/update/remove a text block surrounded by marker lines
    * copy – Copy files to remote locations
    * fetch – Fetch files from remote nodes
    * file – Manage files and file properties
    * find – Return a list of files based on specific criteria
    * ini_file – Tweak settings in INI files
    * iso_extract – Extract files from an ISO image
    * lineinfile – Manage lines in text files
    * patch – Apply patch files using the GNU patch tool
    * read_csv – Read a CSV file
    * replace – Replace all instances of a particular string in a file using a back-referenced regular expression
    * stat – Retrieve file or file system status
    * synchronize – A wrapper around rsync to make common tasks in your playbooks quick and easy
    * tempfile – Creates temporary files and directories
    * template – Template a file out to a remote server
    * unarchive – Unpacks an archive after (optionally) copying it from the local machine
    * xml – Manage bits and pieces of XML files or strings
  * Identity:
    * Ipa
  * Inventory:
    * group_by
  * Monitoring:
    * zabbix_*
  * Net Tools:
    * cloudflare_dns
    * ip_netns
    * ipify_facts
    * ipinfoio_facts
    * lldp
    * nmcli
    * nsupdate
    * omapi_host
    * snmp_facts
    * get_url
    * slurp – Slurps a file from remote nodes (wtf???)
    * uri – Interacts with webservices
    * ldap_*
    * netbox_*
  * Notifications:
    * irc
    * jabber
    * logentries_msg
    * mail
    * pushover
    * syslogger
    * telegram
  * Packaging:
    * Language:
      * pip
      * pip_package_info
    * OS:
      * apt
      * apt_key
      * apt_repo
      * package – Generic OS package manager
      * package_facts – package information as facts
    * Remote Management modules:
      * wakeonlan
      * Dell:
        * idrac_firmware – Firmware update from a repository on a network share (CIFS, NFS)
        * idrac_server_config_profile – Export or Import iDRAC Server Configuration Profile (SCP)
      * HP:
        * hpilo_boot – Boot system using specific media through HP iLO interface
        * hpilo_facts – Gather facts through an HP iLO interface
        * hponcfg – Configure HP iLO interface using hponcfg
      * Ipmi:
        * ipmi_boot – Management of order of boot devices
        * ipmi_power – Power management for machine
      * Source Control:
        * git
        * git_config
        * github_*
        * gitlab_*
      * Storage:
        * zfs
      * System:
        * at – Schedule the execution of a command or script file via the at command
        * capabilities – Manage Linux capabilities
        * cron – Manage cron.d and crontab entries
        * debconf – Configure a .deb package
        * facter – Runs the discovery program facter on the remote system
        * filesystem – Makes a filesystem
        * gather_facts – Gathers facts about remote hosts
        * interfaces_file – Tweak settings in /etc/network/interfaces files
        * ping – Try to connect to host, verify a usable python and return pong on success
        * python_requirements_facts – Show python path and assert dependency versions
        * reboot – Reboot a machine
        * service – Manage services
        * service_facts – Return service state information as fact data
        * setup – Gathers facts about remote hosts
        * sysctl – Manage entries in sysctl.conf
        * systemd – Manage services
        * timezone – Configure timezone setting
        * user – Manage user accounts
        * Firewall:
          * iptables – Modify iptables rules
          * ufw – Manage firewall with UFW
        * SSH:
          * known_hosts – Add or remove a host from the known_hosts file
          * authorized_key – Adds or removes an SSH authorized key
    * Utilities:
      * Logic:
        * assert – Asserts given expressions are true
        * async_status – Obtain status of asynchronous task
        * debug – Print statements during execution
        * fail – Fail with custom message
        * import_playbook – Import a playbook
        * import_role – Import a role into a play
        * import_tasks – Import a task list
        * include – Include a play or task list
        * include_role – Load and execute a role
        * include_tasks – Dynamically include a task list
        * include_vars – Load variables from files, dynamically within a task
        * pause – Pause playbook execution
        * set_fact – Set host facts from a task
        * set_stats – Set stats for the current ansible run
        * wait_for – Waits for a condition before continuing
        * wait_for_connection – Waits until remote system is reachable/usable
    * Web Infastructure:
      * apache2_module – Enables/disables a module of the Apache2 webserver
      * django_manage – Manages a Django application
      * gunicorn – Run gunicorn with various settings
      * htpasswd – manage user files for basic authentication
      * nginx_status_facts – Retrieve nginx status facts
      * supervisorctl – Manage the state of a program or group of programs running via supervisord











