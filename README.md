# simplify installation of tidalcycles and editor(s) with ansible
ansible playbooks for installing the [Tidal Cycles](https://tidalcycles.org) live coding environment with a single command, supporting multiple editors commonly used with Tidal.

Common Tidal-related modifications to the SuperCollider `startup.scd` are also supported, see `vars/all.yml` below  

## NOTE: if you are upgrading from Tidal <= 1.8.1
`tidal 1.9.0` (and later) brings some big changes in the cabal package handling, working best with `cabal >= 3.0.0.0` and a different install command. 

***You need to*** move/delete `~/.ghc` and `~/.cabal` directories, ie completely reset your haskell package environment.

I have now added a [`remove`](./README.md#removal) function to this tool which can setup a clean tidal slate for you

# supported distros
 - ubuntu 24.04, 22.04, 20.04 (and derivatives ie studio kubuntu lubuntu xubuntu etc)
 - debian 12, 11
 - Linux Mint 22, 21, 20
 - ansible >= 2.5

## legacy (Tidal <= 1.8.1)
 - debian 10

### probably also works
 - any other debian based distribution with `cabal >= 3.0.0.0` available

Unsupported:
 - non-linux environments
 - Archlinux/Manjaro (some attempts were made, please check the [arch_support branch](https://github.com/cleary/ansible-tidalcycles/tree/arch_support))
 - other non-debian based linux distributions (patches welcome!)
 - `feedforward` is [no longer receiving maintenance](https://github.com/yaxu/feedforward/issues/37#issuecomment-1266558317), I recommend following progress on **text.management** which has similar goals/features

# usage:

## initial installation

This repository uses git-submodules for roles, so the following clone command is required:

```
sudo apt install ansible git
git clone --recurse-submodules https://github.com/cleary/ansible-tidalcycles.git
cd ansible-tidalcycles/
```
To apply the setup to a local machine, pick a playbook (please note they are not mutually exclusive - try them all out!):

for **tidalcycles standalone**
```
sudo ansible-playbook --connection=local -i localhost, tidal.play.yml
```

for **tidalcycles + vscode**
```
sudo ansible-playbook --connection=local -i localhost, tidal_vscode.play.yml
```

for **tidalcycles + pulsar** (was: atom)
```
sudo ansible-playbook --connection=local -i localhost, tidal_pulsar.play.yml
```

for **tidalcycles + emacs**
```
sudo ansible-playbook --connection=local -i localhost, tidal_emacs.play.yml
```

for **tidalcycles + neovim**
```
sudo ansible-playbook --connection=local -i localhost, tidal_neovim.play.yml
```

for **tidalcycles + vim**
```
sudo ansible-playbook --connection=local -i localhost, tidal_vim.play.yml
```

for **text.management** (experimental)
```
sudo ansible-playbook --connection=local -i localhost, tidal_textmanagement.play.yml
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

## removal

There is a very raw tool for doing removal of tidal related directories.

It is useful when upgrades are failing, `cabal` isn't playing ball, or you may have used the rainbow of install commands available and be in an unknown state.

It will double confirm with you before deleting anything - make sure you understand the message, consequence and have taken care of your own backups of the affected folders.

```
sudo ansible-playbook --connection=local -i localhost, tidal_remove.play.yml
```

The tool does not touch packages installed by the package manager, or editor plugins. They are up to you to deal with.

# roles

## tidal
Install Tidal Cycles (http://tidalcycles.org) and dependencies (SuperCollider, haskell, SuperDirt, SuperDirt-samples etc). 

This role automates the installation of SuperDirt, and SuperDirt samples in SuperCollider. It also writes a basic startup.scd as per [this recommendation](https://github.com/musikinformatik/SuperDirt/blob/develop/superdirt_startup.scd).

If you provide a list of samples paths via the variable *custom_sample_paths* in `vars/all.yml`, these will be added to your startup.scd and loaded on SuperCollider boot.

Please note, this *will* replace any existing startup.scd, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

It will also check for a newer version of `sclang` (eg if installed from source) and skip package installation if a newer version is found

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-base

## vscode
Install the vscode editor from microsoft, including useful plugins for Tidal Cycles and Haskell.

If you provide a list of samples paths via the variable *custom_sample_paths* in `vars/all.yml`, these will be added to your settings.json for the Sound Browser in the tidalcycles plugin.

Please note, this *will* replace any existing settings.json, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vscode

## pulsar (was: atom)
Install the pulsar editor, including useful plugins for Tidal Cycles.

If you provide a list of samples paths via the variable *custom_sample_paths* in `vars/all.yml`, these will be added to your config.cson for the Sound Browser in the tidalcycles plugin.

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-pulsar

## emacs
Install the emacs editor, including the tidal.el plugin for Tidal Cycles.

Please note, this *will* replace any existing `~/.emacs`, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-emacs

## neovim
Install the neovim editor, including the tidal-vim plugin (sans tmux) for Tidal Cycles.

Please note, this *will* replace any existing init.vim, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-neovim

## vim
Install the vim-nox editor, including the tidal-vim plugin (and dependencies) for Tidal Cycles.

Please note, this *will* replace any existing .vimrc, but keep a backup in the same directory, to allow merge/revert. This can be excluded with `--skip-tags "config"`

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-vim

## text.management
Install the (currently experimental) [text.management livecode editor by Matthew Kaney](https://github.com/mindofmatthew/text.management), intended as a dedicated livecode editor, currently supporting tidalcycles out of the box.

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-editor-text_management

## ugens-mutable-instruments
Install the open source [Mutable Instruments](https://mutable-instruments.net/) [Ugens for SuperCollider](https://github.com/v7b1/mi-UGens), configures autoloading required parameter mappings in all editors.

To enable, create/edit `vars/all.yml` (see `vars/all.yml.ex` for examples), and uncomment the lines:
```
sc_ugens: 
    - "mutable-instruments"
```

 - For available Synths, have a look at the [SynthDef](https://raw.githubusercontent.com/cleary/ansible-tidalcycles-synth-mi-ugens/master/files/mutable-instruments-synthdefs.scd)
 - For available options and effects, check out the [parameters.hs](https://raw.githubusercontent.com/cleary/ansible-tidalcycles-synth-mi-ugens/master/files/mutable-instruments-ugens_parameters.hs)

This is a git submodule: https://github.com/cleary/ansible-tidalcycles-synth-mi-ugens

# vars

## all.yml.ex
Support for various custom config attributes can be provided by copying this file to `vars/all.yml` and uncommenting. A summary of options:
 - add a list of paths to local Samples directories, which will be picked up and included in the `startup.scd` file for supercollider, and the Sound Browsers in vscode/pulsar
 - source sample sets/directories from git repositories (curated examples provided)
 - `startup.scd` defaults can be modified here, including `sc.numOutputBusChannels` commonly used for splitting audio outputs to a DAW
 - MIDI clients can be defined with a simple syntax, which then generates the needed entries in `startup.scd`

It is possible to use ansible tags to *only* update the configs (eg if you add a new Sample dir to `vars/all.yml`):
```
sudo ansible-playbook --connection=local -i localhost, tidal_vscode.play.yml --tags "config"
```

# vagrant

Vagrant config files for testing our supported distros. Provisions each of the playbooks against a vagrant box (virtualbox provider) running the specified distro. 

See vagrant/README.md for usage

# todo
* investigate `$ QT_QPA_PLATFORM=offscreen sclang` for starting sc instead of virt display
* add vars for loading custom .hs files to boottidal.hs
* add vars for loading custom .scd files to startup.scd
* add custom synthdefs to vars
* piv4 support `cabal install tidal --lib --ghc-options=-opta-march=armv8.4a` ref jarm@discord
* sc load more file extensions
* sc change recordings dir
* investigate custom quarks

# notes to self:
* `git pull --recurse-submodules`
* `git submodule update --remote [--merge]`
