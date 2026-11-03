kubectl patch settings.longhorn.io taint-toleration \
  -n longhorn-system \
  --type merge \
  -p '{"value":"ai/gpu=true:NoSchedule;server=true:NoSchedule"}'
