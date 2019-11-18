#!/bin/sh

kustomize build . | kubectl apply -f - --dry-run
