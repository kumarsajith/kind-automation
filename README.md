# Project
This project is to automate a Kubernetes cluster creation using kind and configure ingress, prometheus to monitor ingress. Automation is implemented using Ansible scripts and following are the roles/modules available to run with ansible.

NOTE: this is  tested on Ubuntu Linux Version 18.04 [ The script can be run on other linux also with slight modifications and Docker installation. Refer the section at the bottom of this page for details]

1. Create a kind kubernetes multi-node  cluster
2. Install nginx ingress controller  in the  cluster
3. Install prometheus and grafana in the cluster to monitor ingress
4. Install demo apps /foo and /bar to test the ingress
5. Script  to monitor health status of ingress resources and apps
6. Script to query average request, memory and cpu of demo apps


# Dependencies
Please install below dependencies before running the scripts.

Instructions to  install  ansible 
1.  sudo apt-add-repository ppa:ansible/ansible
2.  sudo apt update
3.  sudo apt install ansible

Use below command  to install  git 
1. sudo apt install git

Install jq parser
1. apt  instal jq

# Known Limitations
This scripts are tested only with Ubuntu 18.04, and may not work in other linux distributions. To make it work on other distributions, the pre-requsite role need to be modified.

# Ansible Project Implementation
The overall automation is developed as a pipeline of ansible roles. Note that ansible role is an independent component that can be combined with any ansible automation script.

**Role definitions**
1. **pre-requisite role**: This role is prepare the host VM to install kind kubernetes. The dependencies include docker, kind and helm packaging.
   Every dependency is defined in a seperate yaml file under role/pre-requisiste/tasks folder. 
2. **kubectl role**: This is an existing ansible role developed by community to install docker in host machines. 
3. **cluster role**: This role is to setup a multi node kind cluster in host vm. The tasks are available in roles/cluster/tasks/create-cluster.yml. 

**Please note following related to kind cluster configurations:**

   (a) Note that node configurations are created as a template file under /roles/cluster/templates/cluster-config.yml.j2. Default configuration is a two node cluster    with 1 master and 1 worker nodes. if you want to create a cluster with more nodes edit the template file. You can repeate the role definitions in the file to    create either a master or worker node. 
   
   (b) There are port mappings defined on the above template and this will be used to cofigure host machine ports to kind cluster nodes. If you wish to make changes you can edit these too.
   
   (c) default cluster name is demo. You can edit roles/cluster/defaults/main.yml file to change this. The variable to look for is cluster_name
   
   
4. **nginx role**: this role is created to setup necessary configurations and pods to install prometheus and nginx ingress. These are existing definitions and modified to suite kind cluster configurations. Note that kind cluster require port mapping to be defined before ports can be exposed out of VM. These definitions are available under /pr folder.
5. **demo apps role**: This is to setup demo apps /foo and /bar to test the ingress.

Scripts
There are three scripts created to monitor the health of the cluster, these can be configured as cron-jobs to capture the stats.

1. health.sh : This is to check the general health of the kubernetes cluster. 
2. metrics.sh: This script will query using promQL and create a csv file monitor.csv that will contain date-time-in millis, average http request, average cpu and average memory. Every time when the script run, the values will be appended to the csv file. 
3. app-health.sh: this is used to monitor the health of the foo and bar services. 

Pending:
Need to send email alerts in case of health status failures.

# Quick Start

1. login to your linux machine as root user. [This is tested in Ubunutu 18.04 only]
2. create  a folder for example /kind [you can  create any folder of your choice]
3. clone this repo in /kind [ git clone https://github.com/kumarsajith/kind-automation.git]
4. Make sure that, Dependencies as mentioned above are met.
5. move to folder /kind and run below command to spin off a cluster  
   
   **ansible-playbook cluster-automation.yml**
   
   The automation will run in below sequence to create the cluster
   1. pre-requisite role
   2. kubectl role
   3. cluster role
   4. nginx role
   5. demo apps role

In case, if you want to run the automation from any particular steps, you can edit the cluster-automation.yml file and comment out roles that are not required to be run again. for example, if you want to run only nginx and demo-apps then comment out other modules under the "roles" definition.

Save the file and run ansible-playbook cluster-automation.yml again. Alternatively you can take a copy of the cluster-automation.yml file and edit that too. So in this case you can use ansible-playbook to run the new file instead of cluster-automation.yml

After the cluster is spin off, you can use below scripts to monitor the status
1. health.sh
2. metrics.sh
3. app-health.sh

Note: Ingress is mapped to host port 30080 so use this to check ingress.
To check the services use below urls
1. curl http://localhost:30080/foo
2. curl http://localhost:30080/bar

# Improvements to Monitoring Scripts
Monitoring scripts can be modified to sent notifications in case of health status changes.


# Monitor using Grafana
This setup also configure the cluster monitoring using Grafana. Use below URL of the host machine to access prometheus and grafana

Assume your hostmachine is "demohost" [You can substitute with IP instead of demohost]
1. Prometheus: http://demohost:30091/
2. Grafana: http://demohost:30092

Grafana UI can be configured to monitor ingress cluster. Follow below steps to configure this using Grafana UI.

1. Open http://demohost:30092
2. use admin/admin to login [change password after first time login]
3. From left menu, mouse over gear icon and click on Data Source. 
4. Click on Add a new data source
5. Select prometheus as data source
6. In the prometheus URL type in http://demohost:30091/
7. scroll to bottom of the page and click save and test
8. Now from left menu, mouse over dashboard and select import.
9. Note that you can import many available grafana dashboards. In this case you can type in the number 9614 which is the ingress dashboard template.
10. Select data source as prometheus as created above.
11. click import and now you can see the ingress dashboard in Grafana

Note: Dashboards are available to monitor Kubernetes resources and cluster as well, this can be done by simply importing the desired UI dashboard. Prometheus is already configured to monitor the cluster resuorces, so no additinoal configuration is required.

NOTE: There are other sophisticated tools like Prisma Cloud that can be installed to monitor not only health but also the pod topology and network connections as well.

# Running this script in other linux

The dependecny that may fail while running on linux other than Ubuntu 18.04 would be the pre-requisite ansible role. The docker engine is configured to setup only for Ubuntu. So if you want to run the same script of other linux, do following.

1. open roles/pre-requisite/tasks/main.yml 
2. Comment out the docker.yml import line example #- import_tasks: docker.yml
3. save the file

Install docker for your linux version seperately and then you can run ansible-playbook cluster-automation.yml to spin off a cluster

