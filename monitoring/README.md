## 1. How to deploy Monitoring System (Prometheus/Grafana/...)

1. Create a namespace named `monitoring`

    ```sh
    $ kubectl create ns monitoring
    ```
    
2. Create Grafana dashboard *configmap* object.
    
    ```sh
    $ cd ./grafana-dashboards-configmap
    $ ./create.sh
    ```
    
4. Deploy monitoring system components, e.g. prometheus-server, grafana, prometheus-node-exporter, etc..
    
    ```sh
    $ cd ./local
    $ ./up.sh 
    ```
