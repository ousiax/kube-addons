## How to deploy EFK(Elasticsearch, Fluent-bit, Kibana) on Kubernetes

0. The elasticsearch will run as single node, please label one of your Kuberentes node with a label key `node.efk.io/elasticsearch-storage-ready`.

1. To test the EFK on your personal desktop Kubernetes, please change the work directory to `test/` and run the `up.sh` shell script.

2. To deploy the EFK on development Kubernetes, please change the work directory to `local/` and run the `up.sh` shell script.

## How to access the EFK logging system.

The EFK's Kibana will expose a node type service with port number `32115`, you can access the Kibana with `http://node_ip:32115`.

## Others

There is also a cronjob named `es-curator` to delete elasticsearch indices older than 15 days everyday. 
