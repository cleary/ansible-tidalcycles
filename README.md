# ansible
ansible playbooks/roles for installing various bits and pieces

# roles
 * repos - add custom repos defined in your playbook
 * tidal - install Tidal Cycles (tidalcycles.org)
 * packages - install custom packages defined in playbooks (WIP/todo)

# Usage:
* sudo ansible-pull -U https://github.com/cleary/ansible.git playbooks/tidal --clean

# Todo:
* change packages to install a list of packages
* add basic superdirt startup
* add basic tidal intro file
