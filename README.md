# ansible
ansible playbooks/roles for installing various linux DAW tools on ubuntu >= 20.04

Presently, this exists to simplify the Tidal Cycles live coding environment install, with multiple playbooks supporting common editors used in Tidal (vscode, atom, vim).

# usage:
This repository is now using git-submodules for roles, so use the following clone command:

```
sudo apt install ansible git
git clone --recurse-submodules https://github.com/cleary/ansible.git
cd ansible
```
To apply the setup to a local machine, pick a playbook (please note they are not mutually exclusive - try them all out!):

```
# for tidalcycles + vscode
sudo ansible-playbook --connection=local -i localhost, playbooks/tidal_vscode.yml

# for tidalcycles + atom
sudo ansible-playbook --connection=local -i localhost, playbooks/tidal_atom.yml

# for tidalcycles + vim - warning, it will clobber your .vimrc (but take a backup)
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

# notes to self:
* `git submodule update --remote [--merge]`
