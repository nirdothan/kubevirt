#!/bin/env bash

cluster-up/kubectl.sh --namespace kubevirt scale deployment virt-operator --replicas=0

cluster-up/kubectl.sh  --namespace kubevirt patch deployment virt-controller --type='json' -p '[
  {"op": "remove", "path": "/spec/template/spec/containers/0/readinessProbe"},
  {"op": "remove", "path": "/spec/template/spec/containers/0/livenessProbe"},
  {"op": "replace", "path": "/spec/replicas", "value": 1},
  {"op": "replace", "path": "/spec/template/spec/containers/0/image", "value": "registry:5000/kubevirt/virt-controller:debug"},
  {"op": "replace", "path": "/spec/template/spec/containers/0/imagePullPolicy", "value": "Always"},
  {"op": "replace", "path": "/spec/template/spec/containers/0/command", "value": [
    "/usr/bin/dlv",
    "--listen=:8888",
    "--headless=true",
    "--api-version=2",
    "--accept-multiclient",
    "exec",
    "/usr/bin/virt-controller",
    "--"
  ]}
]'
