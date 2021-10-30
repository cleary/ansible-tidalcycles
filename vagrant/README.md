## package deps
```
sudo apt-get install virtualbox-qt libvirt-daemon libvirt-daemon-driver-vbox
```

## running a single container
```
VAGRANT_VAGRANTFILE=Vagrantfile.ubuntu2004_64 vagrant up --provision
VAGRANT_VAGRANTFILE=./Vagrantfile.ubuntu2004_64 vagrant destroy
```

# todo

stick them all in a single Vagrantfile
