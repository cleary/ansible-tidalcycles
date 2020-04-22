# ansible
ansible playbooks/roles for installing various bits and pieces

# Usage:
This repository is now using git-submodules for roles, so use the following clone command:

```
git clone --recurse-submodules https://github.com/cleary/ansible.git
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

# Todo:
* add other editor roles, atom/vim
* change packages to install a list of packages
* add basic superdirt startup
* add support for sample paths in superdirt startup and vscode/tidalcycles plugin
