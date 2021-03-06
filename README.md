# simplify installation of tidalcycles and editor(s) with ansible
ansible playbooks for installing the [Tidal Cycles](https://tidalcycles.org) live coding environment with a single command, supporting multiple editors commonly used with Tidal

# supported
 - ubuntu 20.04/18.04 (and derivatives ie studio kubuntu lubuntu xubuntu etc)
 - debian 10/9
 - Linux Mint 20/19
 - ansible >= 2.2

Unsupported:
 - non-debian based distros (potentially on my radar though)
 - non-linux environments 

# usage:

## initial installation

This repository uses git-submodules for roles, so the following clone command is required:

```
sudo apt install ansible git
git clone --recurse-submodules https://github.com/cleary/ansible-tidalcycles.git
cd ansible-tidalcycles/
```
To apply the setup to a local machine, pick a playbook (please note they are not mutually exclusive - try them all out!):

```
# for tidalcycles standalone
sudo ansible-playbook --connection=local -i localhost, tidal.play.yml

# for tidalcycles + vscode
sudo ansible-playbook --connection=local -i localhost, tidal_vscode.play.yml

# for tidalcycles + atom
sudo ansible-playbook --connection=local -i localhost, tidal_atom.play.yml

# for tidalcycles + neovim
sudo ansible-playbook --connection=local -i localhost, tidal_neovim.play.yml

# for tidalcycles + vim
sudo ansible-playbook --connection=local -i localhost, tidal_vim.play.yml

# for tidalcycles + feedforward - warning, this is extremely, extremely experimental
sudo ansible-playbook --connection=local -i localhost, tidal_feedforward.play.yml
```
## upgrading

The playbooks are designed to be run and re-run, so just run them again to get latest versions of repository packages, haskell packages, git repos etc.

This repo is under active development, so grabbing the latest changes is recommended (remember the `--recurse-submodules` option):
```
git pull --recurse-submodules
```

The only minor gotcha is if you significantly modify any config files that are templated, eg `.vimrc`, `startup.scd` (please see `vars/all.yml` below), or `settings.json` (vscode) you will need to restore the backed up version (from the install directory) after running - alternatively, you can *exclude* the config writing tasks via the `config` tag:
```
sudo ansible-playbook --connection=local -i localhost, tidal.play.yml --skip-tags "config"
```

# roles

## tidal
Install Tidal Cycles (http://tidalcycles.org) and dependencies (SuperCollider, haskell, SuperDirt, SuperDirt-samples etc). 

This role automates the installation of SuperDirt, and SuperDirt samples in SuperCollider as per [this guide](https://tidalcycles.org/index.php/Start_tidalcycles_and_superdirt_for_the_first_time). It also writes a basic startup.scd as per [this recommendation](https://github.com/musikinformatik/SuperDirt/blob/develop/superdirt_startup.scd).

If you provide a list of samples paths via the variable *custom_sample_paths* in `vars/all.yml`, these will be added to your startup.scd and loaded on SuperCollider boot.

Please note, this *will* replace any existing startup.scd, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-base

## vscode
Install the vscode editor from microsoft, including useful plugins for Tidal Cycles and Haskell.

If you provide a list of samples paths via the variable *custom_sample_paths* in `vars/all.yml`, these will be added to your settings.json for the Sound Browser in the tidalcycles plugin.

Please note, this *will* replace any existing settings.json, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vscode

## atom
Install the atom editor, including useful plugins for Tidal Cycles.

If you provide a list of samples paths via the variable *custom_sample_paths* in `vars/all.yml`, these will be added to your config.cson for the Sound Browser in the tidalcycles plugin.

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-atom

## neovim
Install the neovim editor, including the tidal-vim plugin (sans tmux) for Tidal Cycles.

Please note, this *will* replace any existing init.vim, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-neovim

## vim
Install the vim-nox editor, including the tidal-vim plugin (and dependencies) for Tidal Cycles.

Please note, this *will* replace any existing .vimrc, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vim

## feedforward
Install the **experimental** [feedforward editor](https://github.com/yaxu/feedforward) by [@yaxu](https://github.com/yaxu), VU meter config is automatically included in the startup.scd, and a binary symlink is dropped at `/usr/local/bin/feedforward`

Make sure to check out his [README](https://github.com/yaxu/feedforward/blob/master/README.md), there are lots of gotchas!

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-feedforward

# vars

## all.yml
Support for various custom config attributes can be provided here. The options are documented in `all.yml.ex`, as a summary:
 - add a list of paths to local Samples directories, which will be picked up and included in the `startup.scd` file for supercollider, and the Sound Browsers in vscode/atom
 - source sample sets/directories from git repositories (curated examples provided)
 - `startup.scd` defaults can be modified here, including `sc.numOutputBusChannels` commonly used for splitting audio outputs to a DAW
 - MIDI clients can be defined with a simple syntax, which then generates the needed entries in `startup.scd`

It is possible to use ansible tags to *only* update the configs (eg if you add a new Sample dir to `vars/all.yml`):
```
sudo ansible-playbook --connection=local -i localhost, tidal_vscode.play.yml --tags "config"
```

# vagrant

## Vagrantfile.*
Vagrant config files for our supported distros. Provisions each of the playbooks against a vagrant box (virtualbox provider) running the specified distro. 

Usage:
```
VAGRANT_VAGRANTFILE=Vagrantfile.<distro> vagrant up --provision # initialise and provision
VAGRANT_VAGRANTFILE=Vagrantfile.<distro> vagrant provision      # run all provision tasks against a running box
VAGRANT_VAGRANTFILE=Vagrantfile.<distro> vagrant destroy        # get rid of the box, to allow provision against another clean instance/different distro
# NOTE: add the --provision-with=<role> to provision a specific role only
```

# todo
* try and use docker instead of full vm, should enable simpler CI workflow
* add custom synthdefs to vars
* add midi defs to vars

# notes to self:
* `git submodule update --remote [--merge]`
