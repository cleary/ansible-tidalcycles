# ansible
ansible playbooks/roles for installing various linux DAW tools on ubuntu >= 20.04

Presently, this exists to simplify the [Tidal Cycles](https://tidalcycles.org) live coding environment install, with multiple playbooks supporting common editors used with Tidal (vscode, atom, vim).

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
Install Tidal Cycles (http://tidalcycles.org) and dependencies (SuperCollider, haskell, SuperDirt, SuperDirt-samples etc). 

This role automates the installation of SuperDirt, and SuperDirt samples in SuperCollider as per [this guide](https://tidalcycles.org/index.php/Start_tidalcycles_and_superdirt_for_the_first_time). It also writes a basic startup.scd as per [this recommendation](https://github.com/musikinformatik/SuperDirt/blob/develop/superdirt_startup.scd).

If you provide a list of samples paths via the variable *custom_sample_paths* in your playbook, these will be added to your startup.scd and loaded on SuperCollider boot.

Please note, this *will* replace any existing startup.scd, but keep a backup in the same directory, to allow merge/revert.

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
* add support for sample paths in vscode/tidalcycles plugin
* add basic tidal intro file

# notes to self:
* `git submodule update --remote [--merge]`
