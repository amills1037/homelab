kubectl patch daemonset speaker -n metallb-system --type=strategic -p='{
  "spec": {
    "template": {
      "spec": {
        "tolerations": [
          {
            "key": "node-role.kubernetes.io/control-plane",
            "operator": "Exists",
            "effect": "NoSchedule"
          },
          {
            "key": "node-role.kubernetes.io/master",
            "operator": "Exists",
            "effect": "NoSchedule"
          },
          {
            "key": "ai/gpu",
            "value": "true",
            "effect": "NoSchedule"
          },
          {
            "key": "server",
            "value": "true",
            "effect": "NoSchedule"
          }
        ]
      }
    }
  }
}'
