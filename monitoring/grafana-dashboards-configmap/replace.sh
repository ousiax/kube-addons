#!/bin/sh

kustomize build . | kubectl replace -f -
