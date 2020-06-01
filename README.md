# ansiblise installation of tidalcycles environment(s)
ansible roles for simplifing the [Tidal Cycles](https://tidalcycles.org) live coding environment install, with multiple playbooks supporting common editors used with Tidal (vscode, atom, vim).

**Currently, only supported on ubuntu 20.04 and derivative distros**

# usage:
This repository is now using git-submodules for roles, so use the following clone command:

```
sudo apt install ansible git
git clone --recurse-submodules https://github.com/cleary/ansible-tidalcycles.git
cd ansible-tidalcycles/
```
To apply the setup to a local machine, pick a playbook (please note they are not mutually exclusive - try them all out!):

```
# for tidalcycles standalone - warning, it will clobber an existing startup.scd (but take a backup)
sudo ansible-playbook --connection=local -i localhost, tidal.play.yml

# for tidalcycles + vscode
sudo ansible-playbook --connection=local -i localhost, tidal_vscode.play.yml

# for tidalcycles + atom
sudo ansible-playbook --connection=local -i localhost, tidal_atom.play.yml

# for tidalcycles + vim - warning, it will clobber your .vimrc (but take a backup)
sudo ansible-playbook --connection=local -i localhost, tidal_vim.play.yml
```

# roles

## tidal
Install Tidal Cycles (http://tidalcycles.org) and dependencies (SuperCollider, haskell, SuperDirt, SuperDirt-samples etc). 

This role automates the installation of SuperDirt, and SuperDirt samples in SuperCollider as per [this guide](https://tidalcycles.org/index.php/Start_tidalcycles_and_superdirt_for_the_first_time). It also writes a basic startup.scd as per [this recommendation](https://github.com/musikinformatik/SuperDirt/blob/develop/superdirt_startup.scd).

If you provide a list of samples paths via the variable *custom_sample_paths* in `vars/startup_scd.yml`, these will be added to your startup.scd and loaded on SuperCollider boot.

Please note, this *will* replace any existing startup.scd, but keep a backup in the same directory, to allow merge/revert.

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-base

## vscode
Install the vscode editor from microsoft, including useful plugins for Tidal Cycles and Haskell.

If you provide a list of samples paths via the variable *custom_sample_paths* in your playbook, these will be added to your settings.json for the Sample Path Browser in the tidalcycles plugin.

Please note, this *will* replace any existing settings.json, but keep a backup in the same directory, to allow merge/revert.

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vscode

## atom
Install the atom editor, including useful plugins for Tidal Cycles.

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-atom

## vim
Install the vim-nox editor, including the tidal-vim plugin (and dependencies) for Tidal Cycles.

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vim

## packages
Install custom packages defined in playbooks (WIP/todo)

# vars

## all.yml
Support for various custom config attributes will be/is provided here.
At present, (as a proof of concept) a list of paths to local Samples directories can be provided, and will be picked up and included in the startup.scd file for supercollider, and the vscode/tidalcycles extension browser

# notes to self:
* `git submodule update --remote [--merge]`
