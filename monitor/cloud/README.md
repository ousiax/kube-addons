## Usage

1. Create `cloud.yaml` file

```console
$ cd ./manifests

$ ./cloud.sh

$ ls cloud.yaml 
cloud.yaml
```

Then back to the parent work directory.

2. Look out the `patches` directory, you should custom the `prometheus` and `grafana` ingress host.

3. You may also need to custom the container image at `kustomization.yaml`

```yaml
images:
  - name: k8s.gcr.io/kube-state-metrics/kube-state-metrics
    newName: k8s.gcr.io/kube-state-metrics/kube-state-metrics
    newTag: v2.2.3
  - name: prom/prometheus
    newName: prom/prometheus
    newTag: v2.31.1
  - name: prom/node-exporter
    newName: prom/node-exporter
    newTag: v1.2.2
  - name: grafana/grafana-oss
    newName: grafana/grafana-oss
    newTag: 8.2.3
```

4. Copy `kustomization.yaml`, `manifests/cloud.yaml` and `pathes/` to your operation host.

5. Create `pv` and `pvc` for `prometheus` and `grafana` according to the following spec in your cluster.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  template:
    spec:
      containers:
        - name: grafana
          volumeMounts:
            - name: provisioning-datasources
              mountPath: /etc/grafana/provisioning/datasources
              readOnly: true
            - name: data
              mountPath: /var/lib/grafana
      volumes:
        - name: provisioning-datasources
          configMap:
            name: provisioning-datasources
        - name: data
          persistentVolumeClaim:
            claimName: grafana-storage
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
spec:
  template:
    spec:
      containers:
        - name: prometheus
          volumeMounts:
            - name: prometheus-storage
              mountPath: /prometheus
      volumes:
        - name: prometheus-storage
          persistentVolumeClaim:
            claimName: prometheus-storage
```

6. Run `kubectl apply -k .` to deploy.
