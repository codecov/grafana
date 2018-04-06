#!/usr/bin/env bash

while true; do
  if nc -z -v -w 1 postgres 5432; then
    break
  else
    sleep 1
  fi
done

while true; do
  if curl -s http://bootstrap:5000/; then
    break
  else
    sleep 1
  fi
done

if [ -f "/etc/grafana/provisioning/dashboards/sample.yaml" ]; then
  rm -f "/etc/grafana/provisioning/dashboards/sample.yaml"
fi

if [ -f "/etc/grafana/provisioning/datasources/sample.yaml" ]; then
  rm -f "/etc/grafana/provisioning/datasources/sample.yaml"
fi

mkdir -p /etc/grafana/dashboards

curl http://bootstrap:5000/grafana/provisioning/datasources/graphite.yaml -o /etc/grafana/provisioning/datasources/graphite.yaml
curl http://bootstrap:5000/grafana/provisioning/dashboards/asyncy.yaml -o /etc/grafana/provisioning/dashboards/asyncy.yaml
curl http://bootstrap:5000/grafana/dashboards/graphite-carbon-metrics_rev2.json -o /etc/grafana/dashboards/graphite-carbon-metrics_rev2.json

/run.sh
