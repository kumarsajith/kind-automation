# Project
This project is to automate a Kubernetes cluster creation using kind and configure ingress, prometheus to monitor ingress. Automation is implemented using Ansible scripts and following are the roles/modules available to run with ansible.

NOTE: this is  tested on Ubuntu Linux Version 18.04

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

# Known Limitations
This scripts are tested only with Ubuntu 18.04, and may not work in other linux distributions. To make it work on other distributions, the pre-requsite role need to be modified.

# Ansible Project Implementation
The overall automation is developed as ansible roles as below. Note that ansible role is an independent component that can be combined with any ansible automation script.

Role definitions
1. pre-requisite role: This role is prepare the host VM to install kind kubernetes. The dependencies include docker, kind and helm packaging.
   Every dependency is defined in a seperate yaml file under role/pre-requisiste/tasks folder. 
2. kubectl role: This is an existing ansible role developed by community to install docker in host machines. 
3. cluster role: This role is to setup a multi node kind cluster in host vm. The tasks are available in roles/cluster/tasks/create-cluster.yml. 
   Note that node configurations are created as a template file under /roles/cluster/templates/cluster-config.yml.j2. Default configuration is a two node cluster    with 1 master and 1 worker nodes. if you want to create a cluster with more nodes edit the template file. You can repeate the role definitions in the file to    create either a master or worker node.
   
5. 

# Quick Start

1. login to your linux machine.
2. create  a folder for example /opt/kind [you can  create any folder of your choice]
3. clone this repo in /opt/kind
4. run  ansible-playbook cluster-automation.yml -v 

In case of any errors,  you can run specific role/module as follows.
1. Edit the cluster-automation.yml file  and comment the roles you dont want to run. for  example,  if  you want to run only nginx installation,  do following in  cluster-configuration.yml

---

- hosts: localhost
  become: true
  roles:
'#    - pre-requisites
'#    - kubectl
'#    - cluster
    - nginx
'#   - prometheus
'#    - demo-apps


# Organization of cluster automation
This  script  is oragnized as a set of independent roles that will  do following installations.  An  ansible role like a module/component  that can be run independently.

1. pre-requisites : This role/module is to install pre-requisities required  to run kubernetes in linux. Following  pre-reqisites are installed with this script.
   a. Docker
   b. 
   


