#!/bin/sh
# https://github.com/kubernetes/kubernetes/issues/39557
# "Failed to setup network for pod \ using network plugins \"cni\": no IP addresses available in network: podnet; Skipping pod"
kubeadm reset -f
systemctl stop kubelet
systemctl stop docker
rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*
rm -rf /etc/cni/
ifconfig cni0 down
ifconfig flannel.1 down
ifconfig docker0 down
ip link delete cni0
ip link delete flannel.1
systemctl start docker
