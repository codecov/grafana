FROM grafana/grafana:5.0.4
RUN apt-get update && apt-get -y install netcat-traditional
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
