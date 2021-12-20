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
This script depends on  following modules.

1.  Ansible
