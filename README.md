# kind-automation
This project contains automation to do following activities in  linux.

NOTE: this is  tested on Ubuntu Linux Version 18.04

1. Create a kind kubernetes multi-node  cluster
2. Install nginx ingress controller  in the  cluster
3. Install prometheus and grafana in the cluster to monitor ingress
4. Install demo apps /foo and /bar to test the ingress
5. Script  to monitor health status of ingress resources
6. Script to query average request, memory and cpu of demo apps



# Dependencies
This is an automation based on ansible and must be installed on the server.

Instructions to  install  ansible 
1.  sudo apt-add-repository ppa:ansible/ansible
2.  sudo apt update
3.  sudo apt install ansible

git needs to be installed on the machine. To install git, use  the  commadn  "sudo apt install git"


# Quick Start

1. login to your linux machine.
2. create  a folder for example /opt/kind [you can  create any folder of your choice]
3. clone this repo in /opt/kind
4. run  ansible-playbook cluster-automation.yml -v 

# Organization of cluster automation
This  script  is oragnized as a set of independent roles that will  do following installations.  An  ansible role like a module/component  that can be run independently.

1. pre-requisites : This role/module is to install pre-requisities required  to run kubernetes in linux. Following  pre-reqisites are installed with this script.
   a. Docker
   b. 
   


