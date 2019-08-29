# Introduction to aws-csr-ansible project
* * *
Welcome to aws-csr-ansible project. The aim of this project is to help you with a sample project repository that outlines
the setup needed, to setup your own custom projects with custom deployment types and integrate it with Heighliner.

Integrations
-----------
This table contains URLs of integrations related to this project.

**NB:**
+ Jenkins link will not function unless you have run heighliner ci or created your Git via our UI/API.


| Integration | URL           |
| ----------- | ------------- |
| Jira        | https://gis-jira.cisco.com/jira (if you need a Jira project go here: https://codeon.cisco.com/tools/jira/ui )    |
| Jenkins     | https://ci8.cisco.com/job/IT-GIS-SDLC/job/SDLC/job/aws-csr-ansible/ |


## Getting Started

These instructions will get a copy of the project up and running on your local machine for development and testing purposes.

### Pre-requisites:
- The following software should be installed on your local machine
    - [Vagrant](https://www.vagrantup.com/docs/installation/)
    - [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- SDLC Deploy server Public Keys should be added on to each of the target host's   ~/.ssh/authorized_keys file

### Installing

Clone the repository to a directory of your choice.
```
git clone ssh://git@gitscm.cisco.com/sdlc/aws-csr-ansible.git
```
Change to the aws-csr-ansible directory and run `vagrant up`. This will bring up the VirtualBox VM and install this Ansible module on the VM.
Please be aware that installation can take up to 20 minutes to complete depending on your network.

# .codeon.yml
* * *
This file defines each component that feeds the HEIGHLINER Tool to create/update the CI/CD pipeline.

### admin_ad_group:
Admin AD group to provide privileged access to your team on the Deployment tool set
### team_mailer_alias:
Mailer alias for your team for all notifications
### it_application:
Tags the git repo with the application in [CDA](https://cdanalytics.cisco.com).
### lifecyles: 
Defines the application lifecycle environments for deployment. Format followed for specifying lifecyles,
```
lifecycles:
  development:
    - dev
    - dev2
  staging:
    - stg
  production:
    - prd1
    - prd2
```
 Here __development__, __staging__ and __production__ are called phases. The names of these phases cannot be changed, 
 however the environments listed underneath each phase can be of any name.

### check:
Check section is for including the pre-checks that should be executed before the build job commences on Jenkins.
It points to the check.sh script under tools directory.
-  __image__ : Docker Container Image on which the check script is executed as root on Jenkins
    - The image name should be of the form \<registry-name>\/\<image-name>\:\<tag>
        - If no registry-name is specified, default registry-name is taken as Docker Hub
        - Cisco IT Internal Docker Registry can be found at https://containers.cisco.com
        - Default tag is latest
    - If no option is specified, Heighliner will run this on the default CentOS 7 Image
- __script__: Path to the check script.

### build:
Build section is to build the desired package type on Jenkins server and upload it to Artifactory.
This typically could be a tar.gz or .jar or .whl or .rpm package.
-  __image__ : Docker Container Image on which the build script is executed as root on Jenkins
    - The image name should be of the form \<registry-name>\/\<image-name>\:\<tag>
        - If no registry-name is specified, default registry-name is taken as Docker Hub
        - Cisco IT Internal Docker Registry can be found at https://containers.cisco.com
        - Default tag is latest
    - If no option is specified, Heighliner will run this on the default CentOS 7 Image
- __script__: Path to the build script.
### deploy:
Deploy section defines the deployment path that should be setup for deploying/executing the samplebash scripts.
- __type__: Indicates the deployment type, in this case its custom
-  __image__ : Docker Container Image on which the deploy script is executed as root
    - The image name should be of the form \<registry-name>\/\<image-name>\:\<tag>
        - If no registry-name is specified, default registry-name is taken as Docker Hub
        - Cisco IT Internal Docker Registry can be found at https://containers.cisco.com
        - Default tag is latest
    - If no option is specified, Heighliner will run this on the default CentOS 7 Image
- __platform__:  "platform" defines the deployment solution to be used
    - Supported deployment platforms are: uDeploy, Jenkins (case insensitive)
    - Incase platform field is not present, default platform is always choosen as uDeploy
- __script__: path to deploy.sh script
### verify:
- __verify__: This section contains all of the tasks and types of functional and non-functional testing that should occur post-deployment.
    - __type__: This can be either "custom" or "norad". Please make sure to go through the setting up [process](https://codeon-dev.cisco.com/tutorials/norad-setup) before using Norad.
    More info on the custom type can be found in our [reference](https://codeon.cisco.com/tutorials/heighliner-reference#heighliner-verify) section.
    -   __image__ : Docker Container Image on which the verify script is executed as root
        - The image name should be of the form \<registry-name>\/\<image-name>\:\<tag>
            - If no registry-name is specified, default registry-name is taken as Docker Hub
            - Cisco IT Internal Docker Registry can be found at https://containers.cisco.com
            - Default tag is latest
        - If no option is specified, Heighliner will run this on the default CentOS 7 Image
    -   __script__ : This should be the path to the test script that will be executed.


# tools
* * *

### ./tools/check.sh
Heighliner Check job executes this script on Jenkins server for every code Commit to GIT.

### ./tools/build.sh
Heigliner build job executes this script on the Jenkins server to build the desired package.

This file contains the commands required to create the target package type through Jenkins.
```
reponame - Repository Name, extracted from GIT_URL. Ex : ssh://git@gitscm.cisco.com/sdlc/sample-bash.git
BUILD_NUMBER - Jenkins Build Number
```

If the target package required is a tar.gz file, then build.sh can be completely ignored,
as HEIGHLINER build creates a tar.gz of the entire repository by default.
### ./tools/deploy.sh
Heighliner deploy job executes this script on the SDLC Deploy server and passes "lifecycle" variable as the first input argument
and "artifact_path" as the second argument to deploy.sh. This is as per the order defined in .codeon.yml under deploy section.
