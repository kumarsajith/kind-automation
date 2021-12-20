#! /bin/bash

#curl avg(rate(promhttp_metric_handler_requests_total[5m]))

#curl avg(rate(nginx_ingress_controller_nginx_process_cpu_seconds_total[5m]))

#curl  avg(rate(nginx_ingress_controller_nginx_process_virtual_memory_bytes[5m]))

#curl http://localhost:30091/api/v1/query?query=avg%28rate%28promhttp_metric_handler_requests_total%5B5m%5D%29%29

#curl http://localhost:30091/api/v1/query?query=avg%28rate%28nginx_ingress_controller_nginx_process_cpu_seconds_total%5B5m%5D%29%29

#curl http://localhost:30091/api/v1/query?query=avg%28rate%28nginx_ingress_controller_nginx_process_virtual_memory_bytes%5B5m%5D%29%29


cpu=$(curl -s http://localhost:30091/api/v1/query?query=avg%28rate%28nginx_ingress_controller_nginx_process_cpu_seconds_total%5B5m%5D%29%29 | jq -r '.data.result[0].value[1]')

req=$(curl -s http://localhost:30091/api/v1/query?query=avg%28rate%28promhttp_metric_handler_requests_total%5B5m%5D%29%29 | jq -r '.data.result[0].value[1]')

memory=$(curl -s http://localhost:30091/api/v1/query?query=avg%28rate%28nginx_ingress_controller_nginx_process_virtual_memory_bytes%5B5m%5D%29%29 | jq -r  '.data.result[0].value[1]')


echo $cpu, $req, $memory >> monitor.csv







