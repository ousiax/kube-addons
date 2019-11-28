#### # Backup Kubernetes PKI
#### # Backup Kubernetes Etcd database with a CronJob object

***The CronJob must be scheduled to Kubernetes Master node.***

#### # Recovery from Master Failure with Kubeadm

```sh
#/bin/sh

#####################################
# Recovery from Master Failure      #
#####################################

if kubectl cluster-info > /dev/null 2>&1; then
    kubectl cluster-info
    exit 0
fi

KUBE_BACKUP_DIR="/kubernetes/backup"

# Same image as in /etc/kubernetes/manifests/etcd.yaml
ETCD_IMAGE="k8s.gcr.io/etcd:3.3.15-0"
ETCDCTL_API=3

ETCD_SNAPSHOT="etcd-2019-11-28_05-52-20_UTC.db"
PKI_SNAPSHOT="pki-2019-11-28_05-04-06_UTC"

# Restore Kubernetes certificates
KUBE_CERT_DIR="/etc/kubernetes"
BACKUP_CERT_DIR="$KUBE_BACKUP_DIR/$PKI_SNAPSHOT"
mkdir -p $KUBE_CERT_DIR 
cp -R $BACKUP_CERT_DIR $KUBE_CERT_DIR/pki

# Restore etcd data
mkdir -p /var/lib/etcd
docker run --rm \
    -v "$KUBE_BACKUP_DIR:/kubernetes/backup" \
    -v '/var/lib/etcd:/var/lib/etcd' \
    --env ETCDCTL_API=$ETCDCTL_API \
    "$ETCD_IMAGE" \
    /bin/sh -c "etcdctl snapshot restore '/kubernetes/backup/$ETCD_SNAPSHOT'; mv /default.etcd/member/ /var/lib/etcd/"

# Init Kubernetes with Kubeadm
kubeadm init \
    --ignore-preflight-errors=DirAvailable--var-lib-etcd
```
