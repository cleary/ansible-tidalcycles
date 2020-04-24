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
# for vscode
sudo ansible-playbook --connection=local -i localhost, playbooks/tidal_vscode.yml

# for atom
sudo ansible-playbook --connection=local -i localhost, playbooks/tidal_atom.yml

# for vim - warning, it will clobber your .vimrc (but take a backup)
sudo ansible-playbook --connection=local -i localhost, playbooks/tidal_vim.yml
```

# roles

## tidal
Install Tidal Cycles (http://tidalcycles.org) and dependencies (supercollider, haskell etc).
This is a git submodule: https://github.com/cleary/ansible-tidalcycles-base

## vscode
Install the vscode editor from microsoft, including useful plugins for Tidal Cycles and Haskell.
This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vscode

## atom
Install the atom editor, including useful plugins for Tidal Cycles.
This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-atom

## vim
Install the vim-nox editor, including the tidal-vim plugin (and dependencies) for Tidal Cycles.
This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vim

## packages
Install custom packages defined in playbooks (WIP/todo)

# todo:
* change packages to install a list of packages
* add basic superdirt startup
* add support for sample paths in superdirt startup and vscode/tidalcycles plugin
* add basic tidal intro file

# Notes to self:
* `git submodule update --remote [--merge]`
