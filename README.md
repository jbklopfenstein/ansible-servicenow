# Intro to ansible-servicenow project
* * *
Welcome to the ansible-servicenow project.

This is a general change-management playbook designed to take in and execute user-defined Ansible Roles and Tasks, and then additionally make a follow-up API call upon completion.
The example playbook will perform the listed roles and tasks, and then optionally end with the suitable API call to ServiceNow.
Note that the Ansible modules used will determine the version of Ansible required.

Use-Case
-----------
This simple structure allows deployment and operations teams to share common playbooks that have been standardized for specific actions while supporting individual Roles.
For example, while the example provided here has the specific action of connecting to a Cisco CSR router in an AWS account, making a change to an interface, and then calling a ServiceNow API to update ticket status, 
other roles and/or tasks (and follow-up API calls) can be substituted (provided that a compatible Ansible version is used with the chosen modules).  
If different Ansible versions are required, consider using virtual envs or containers to maintain such dependencies for different playbooks.

Description of Example Code 
-----------
- Uses an Ansible Role which uses the Ansible *Cisco ios_config module*, and is known to work on the specified Ansible version specified below.
- The ios_config module is used to connect to an IOS device, in this case a CSR router, and make the defined configuration change, in this case a interface state change.
- The example CSR router happens to be in an AWS account, so part of the module specifies an AWS SSH keyfile for authentication.
- The follow-up API call uses the Ansible *uri module* to call a ServiceNow API that has been previously exposed.
- It will tell ServiceNow to close a given ticket as **successful** or **unsuccessful** depending on whether or not all the playbook actions completed successfully.


Local/Control Machine Info
-----------
```
$ cat /etc/issue
Debian GNU/Linux 9 \n \l

$ uname -a
Linux 12c25485804c 5.0.0-27-generic #28~18.04.1-Ubuntu SMP Thu Aug 22 03:00:32 UTC 2019 x86_64 GNU/Linux
 
$ ansible --version
ansible 2.4.2.0
  config file = None
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python2.7/site-packages/ansible
  executable location = /usr/local/bin/ansible
  python version = 2.7.16 (default, Jul 12 2019, 01:42:49) [GCC 6.3.0 20170516]

```

Prerequisites
-----------
- Understanding of Ansible Modules and Roles
- Working knowledge of ServiceNow APIs
- Working knowledge of Cisco CLI
- Working knowledge of AWS

