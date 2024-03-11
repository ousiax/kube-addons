## How to deploy EFK(Elasticsearch, Fluent-bit, Kibana) on Kubernetes

1. To test the EFK stack suite on your personal desktop Kubernetes, please change the work directory to `test/` and run the `up.sh` shell script. It will use a `emptyDir` volume as the backend storage of the Elastic Search service.

2. If you want to keep the elastic search data with `local` persistent volume, please go to `./local` and run `kubectl apply -k .`

    The elasticsearch will run as single node, please label one of your Kuberentes node with a label key `node.local.io/elasticsearch-storage=local`.

## How to access the EFK logging system.

The EFK's Kibana will expose a ingress named `kiba.dev.test`, you can access the Kibana with `http://kiba.dev.test`.

## Others

There is also a cronjob named `curator` to delete elasticsearch indices older than 45 days at 23:30 everyday. 
