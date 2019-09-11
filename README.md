# Intro to ansible-servicenow project
* * *
Welcome to the ansible-servicenow project.

This is a simple Ansible playbook for adding Roles and Tasks within a Block and Rescue structure which allows the customization of additional REST API callback actions.

This simple structure allows deployment and operations teams to share a common playbook that has been standardized for a specific set of actions while supporting their individual Roles.

The example playbook provided here has the specific action of connecting to a Cisco CSR router in an AWS account, making a change to an interface, and then calling a ServiceNow API to update ticket status.  Other roles and/or tasks can be added as well.

The follow-up API call to ServiceNow will close a given ticket as successful or unsuccessful depending on whether or not all playbook actions completed successfully.


Local/Control Machine Info
-----------
```
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.3 LTS
Release:	18.04
Codename:	bionic

$ uname -a
Linux jeff-VirtualBox5 5.0.0-27-generic #28~18.04.1-Ubuntu SMP Thu Aug 22 03:00:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

$ ansible –version
ansible 2.8.3
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/jeff/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.15+ (default, Jul  9 2019, 16:51:35) [GCC 7.4.0] 

```

