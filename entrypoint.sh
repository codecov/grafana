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

curl http://bootstrap:5000/grafana/provisioning/dashboards/asyncy.yaml -o /etc/grafana/provisioning/dashboards/asyncy.yaml

data_sources="prometheus"
for data_source in $data_sources; do
  curl http://bootstrap:5000/grafana/provisioning/datasources/$data_source.yaml -o /etc/grafana/provisioning/datasources/$data_source.yaml
done

dashboards="grafana prometheus traefik"
for dashboard in $dashboards; do
  curl http://bootstrap:5000/grafana/dashboards/$dashboard.json -o /etc/grafana/dashboards/$dashboard.json
done

grafana-cli plugins install grafana-piechart-panel
/run.sh
