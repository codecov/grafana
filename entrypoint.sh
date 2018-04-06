#!/usr/bin/env bash

while true; do
  if curl http://bootstrap:5000/; then
    break
  else
    sleep 1
  fi
done
rm -f /etc/grafana/provisioning/dashboards/sample.yaml /etc/grafana/provisioning/datasources/sample.yaml
curl http://bootstrap:5000/grafana/provisioning/datasources/graphite.yaml -o /etc/grafana/provisioning/datasources/graphite.yaml
curl http://bootstrap:5000/grafana/provisioning/dashboards/asyncy.yaml -o /etc/grafana/provisioning/dashboards/asyncy.yaml
mkdir /etc/grafana/dashboards/
curl http://bootstrap:5000/grafana/dashboards/graphite-carbon-metrics_rev2.json -o /etc/grafana/dashboards/graphite-carbon-metrics_rev2.json
/run.sh
