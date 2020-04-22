# ansible
ansible playbooks/roles for installing various bits and pieces in Ubuntu Linux (primarily, it may be trivial to port it to other distros). I tend to track current releases, so don't expect support for versions older than current (but checkout older code!)

# usage:
This repository is now using git-submodules for roles, so use the following clone command:

```
sudo apt install ansible git
git clone --recurse-submodules https://github.com/cleary/ansible.git
cd ansible
```
To apply the setup to a local machine:

```
sudo ansible-playbook --connection=local -i localhost, playbooks/tidal_vscode.yml
```

# roles

## tidal
Install Tidal Cycles (http://tidalcycles.org) and dependencies (supercollider, haskell etc).
This is a git submodule: https://github.com/cleary/ansible-tidalcycles-base

## vscode
Install the vscode editor from microsoft, including useful plugins for Tidal Cycles and Haskell.

## packages
Install custom packages defined in playbooks (WIP/todo)

# todo:
* add other editor roles, atom/vim
* change packages to install a list of packages
* add basic superdirt startup
* add support for sample paths in superdirt startup and vscode/tidalcycles plugin
