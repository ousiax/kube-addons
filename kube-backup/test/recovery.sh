#/bin/sh

#####################################
# Recovery from Master Failure      #
#####################################

if kubectl cluster-info > /dev/null 2>&1; then
    kubectl cluster-info
    exit 0
fi

# Restore Kubernetes certificates
KUBE_CERT_DIR="/etc/kubernetes"
PKI_SNAPSHOT="2019-08-20_01-49-47_UTC"
BACKUP_CERT_DIR="/kubernetes/backup/pki/$PKI_SNAPSHOT"
mkdir -p $KUBE_CERT_DIR 
cp -a $BACKUP_CERT_DIR $KUBE_CERT_DIR

# Restore etcd data
# Same image as in /etc/kubernetes/manifests/etcd.yaml
ETCD_IMAGE="k8s.gcr.io/etcd:3.3.10"
# ETCD_SNAPSHOT="2019-05-21_06-48-06_UTC.db"
ETCD_SNAPSHOT="2019-08-20_01-49-47_UTC.db"
mkdir -p /var/lib/etcd
docker run --rm \
    -v '/kubernetes/backup:/kubernetes/backup' \
    -v '/var/lib/etcd:/var/lib/etcd' \
    --env ETCDCTL_API=3 \
    "$ETCD_IMAGE" \
    /bin/sh -c "etcdctl snapshot restore '/kubernetes/backup/etcd/$ETCD_SNAPSHOT' ; mv /default.etcd/member/ /var/lib/etcd/"

# Init Kubernetes with Kubeadm
kubeadm init \
    --ignore-preflight-errors=DirAvailable--var-lib-etcd
