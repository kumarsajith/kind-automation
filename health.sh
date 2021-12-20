#! /bin/bash


result=$(curl -k -s https://localhost:42617/livez?verbose | grep "livez check passed")

if [[ "$result" ==  "" ]]; then
  echo "Cluster check failed"
  curl -k https://localhost:42617/livez?verbose  
else
   echo "Cluster check passed"
fi 

