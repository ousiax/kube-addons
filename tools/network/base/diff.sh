#!/bin/sh

kustomize build . | kubectl diff -f -
