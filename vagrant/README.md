# vagrant/

Vagrant config files for testing our supported distros. Provisions each of the playbooks against a vagrant box (virtualbox provider) running the specified distro. 

## package deps

For VirtualBox: 
```
sudo apt-get install vagrant virtualbox-qt libvirt-daemon libvirt-daemon-driver-vbox
```

## running a single container

Usage:

```
VAGRANT_VAGRANTFILE=Vagrantfile.<distro> vagrant up --provision [--provider=virtualbox | libvirt] # initialise and provision
VAGRANT_VAGRANTFILE=Vagrantfile.<distro> vagrant provision      # run all provision tasks against a running box
VAGRANT_VAGRANTFILE=Vagrantfile.<distro> vagrant destroy        # get rid of the box, to allow provision against another clean instance/different distro
# NOTE: add the --provision-with=<role> to provision a specific role only
```

# todo

stick them all in a single Vagrantfile
