# Labels

## Kubernetes
node-type:
+ ai
+ cluster
+ server
    
```console
kubectl label node rasp1 node-type=cluser
kubectl label node rasp2 node-type=cluser
kubectl label node rasp3 node-type=cluser

kubectl label node devel node-type=server
kubectl label node external node-type=server

kubectl label node aila node-type=ai
```
