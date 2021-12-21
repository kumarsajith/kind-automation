#! /bin/bash

# get API end point from kube config
get_server_from_kube=$(cat ~/.kube/config | grep server:)
server_url=${get_server_from_kube/server:/}

result=$(curl -k -s $server_url/livez?verbose | grep "livez check passed")

if [[ "$result" ==  "" ]]; then
  echo "Cluster check failed"
  curl -k https://localhost:42617/livez?verbose  
else
   echo "Cluster check passed"
fi 

