#!/bin/sh

# kustomize build . | kubectl delete -f -
kubectl delete -k .
