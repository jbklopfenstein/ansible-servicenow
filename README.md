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

Example Execution
-----------
Here is a capture of basic execution targeting a Cisco CSR on the Cisco DevNet Always-On Sandbox
* [Practice using Cisco CSR on DevNet](https://devnetsandbox.cisco.com/RM/Diagram/Index/38ded1f0-16ce-43f2-8df5-43a40ebf752e?diagramType=Topology)

Ensure target is added to known hosts
```
$ ssh developer@ios-xe-mgmt-latest.cisco.com -p 8181
The authenticity of host '[ios-xe-mgmt-latest.cisco.com]:8181 ([64.103.37.8]:8181)' can't be established.
RSA key fingerprint is SHA256:+ChihJ4vSUJteAzP9X8IfXIXmvEBPcvGMtSLTT+sGCU.
Are you sure you want to continue connecting (yes/no)? yes

Warning: Permanently added '[ios-xe-mgmt-latest.cisco.com]:8181' (RSA) to the list of known hosts.
Password: 

Welcome to the DevNet Sandbox for CSR1000v and IOS XE

The following programmability features are already enabled:
  - NETCONF
  - RESTCONF

Thanks for stopping by.


csr1000v-1#exit
```

Verify use of a compatible Ansible version
```
(base)$ conda activate heighlinerenv

(heighlinerenv)$ ansible --version
ansible 2.4.2.0
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/home/jeff/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /home/jeff/anaconda3/envs/heighlinerenv/lib/python2.7/site-packages/ansible
  executable location = /home/jeff/anaconda3/envs/heighlinerenv/bin/ansible
  python version = 2.7.16 |Anaconda, Inc.| (default, Aug 22 2019, 16:00:36) [GCC 7.3.0]
``` 

Execute Playbook
```
(heighlinerenv)$ ansible-playbook test-csr-play.yml 
[WARNING]: Could not match supplied host pattern, ignoring: all

[WARNING]: provided hosts list is empty, only localhost is available


PLAY [Modular playbook with Roles in a Block and Rescue] *****************************************************************************

TASK [include_role] ******************************************************************************************************************

TASK [change_transitcsr_config : Configure Int] **************************************************************************************
changed: [localhost]

TASK [change_transitcsr_config : debug] **********************************************************************************************
ok: [localhost] => {
    "msg": "this task is successful"
}

TASK [this is an example shell command task to demonstrate tasks in addition to roles] ***********************************************
changed: [localhost]

TASK [debug] *************************************************************************************************************************
ok: [localhost] => {
    "msg": "all roles and actions sucessful"
}

PLAY RECAP ***************************************************************************************************************************
localhost                  : ok=4    changed=2    unreachable=0    failed=0   

(heighlinerenv)$

```
