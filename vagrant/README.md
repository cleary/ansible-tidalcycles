## package deps
```
sudo apt-get install virtualbox-qt libvirt-daemon libvirt-daemon-driver-vbox
```

## running a single container
```
VAGRANT_VAGRANTFILE=Vagrantfile.ubuntufocal64 vagrant up --provision
VAGRANT_VAGRANTFILE=./Vagrantfile.debianstretch64 vagrant destroy
```

## running all the containers
```
find ./ -iname "Vagrantfile\.*" | while read line; do 
  VAGRANT_VAGRANTFILE=${line} vagrant up --provision; 
done
```

# todo

stick them all in a single Vagrantfile
