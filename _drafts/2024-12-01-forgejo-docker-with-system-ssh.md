---
title: Forejo docker with system SSH.
# date: 2024-04-07 00:00:01 -0400
categories: [git,ssh]
tags: [git,ssh]
author: dmcken
comments: false
---

Problem definition: Setup a forgejo with docker + docker compose on Ubuntu 24.04.

1. Install OS, with a non-root account with wheel access.
2. `apt update && apt upgrade`
3. Add a git user:
```bash
sudo adduser git
[sudo] password for dmcken:
info: Adding user `git' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `git' (1001) ...
info: Adding new user `git' (1001) with group `git (1001)' ...
info: Creating home directory `/home/git' ...
info: Copying files from `/etc/skel' ...
New password:
Retype new password:
passwd: password updated successfully
Changing the user information for git
Enter the new value, or press ENTER for the default
        Full Name []: git
        Room Number []:
        Work Phone []:
        Home Phone []:
        Other []:
Is the information correct? [Y/n] y
info: Adding new user `git' to supplemental / extra groups `users' ...
info: Adding user `git' to group `users' ...
```
Of note is the line "Adding new user git (XXXX) with group git (YYYY)" which indicates the group ID is 1001 (YYYY) and user id is 1001 (XXXX). A fresh install of Ubuntu your values should be 1001 but could be different, we will need these values for later steps.
4. Create `docker-compose.yml` with the following contents:
5. Start the container to create the base files.
6. Make link from the "real" git user's .ssh to forgejo's version:
```bash
sudo -u git ln -s /home/dmcken/forgejo/forgejo/git/.ssh /home/git/.ssh
```
7. Generate a ssh key under the git user.
```bash

```



## References
* https://www.ateijelo.com/blog/2016/07/09/share-port-22-between-docker-gogs-ssh-and-local-system


## Current setup

* SSH redirect not working atm.
