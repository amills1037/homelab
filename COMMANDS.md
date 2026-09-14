# Useful command line commands

## Kubernetes commands

List node taints
```console
kubectl get nodes -o json | \
jq '.items[] | select(.spec.taints != null) | {name: .metadata.name, taints: .spec.taints}'
```

List node labels
```console
kubectl get nodes -o json | \
jq '.items[] | {name: .metadata.name, labels: .metadata.labels}'
```

## Ansible commands


## Shell commands
