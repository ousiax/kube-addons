## Usage

1. Select a node as the local storage by making the specific labels and directories on it for Grafana and Prometeus. 

```sh
kubectl label nodes <NODE-NAME> node.local.io/grafana-storage=local
kubectl label nodes <NODE-NAME> node.local.io/prometheus-storage=local
sudo mkdir -p /kube/{grafana,prometheus}/db
```

2. You may also need to custom the images at `kustomization.yaml`

```yaml
images:
  - name: registry.k8s.io/kube-state-metrics/kube-state-metrics
    newName: bitnami/kube-state-metrics
    newTag: 2.10.1
  - name: prom/prometheus
    newTag: v2.50.1
  - name: prom/node-exporter
    newTag: v1.7.0
  - name: grafana/grafana-oss
    newTag: 10.2.4
```

3. Run `kubectl apply -k .` to deploy.

4. Browser the Grafana with http://grafa.dev.test, and import the following usefull dashbaords:

```yml
dashboards:
  - name: Kubernetes Monitor
    id: 15398
    url: https://grafana.com/grafana/dashboards/15398

  - name: NGINX Ingress controller
    id: 9614
    url: https://grafana.com/grafana/dashboards/9614

  - name: Node Exporter Full
    id: 1860
    url: https://grafana.com/grafana/dashboards/1860
```
