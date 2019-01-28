# Ubiquiti Edgerouter metrics for Prometheus
This repo contains both a generator specification for use with the Prometheus
project's snmp_exporter generator tool and a generated configuration file,
`snmp.yml`. The snmp exporter can be run in conjunction with a Prometheus server
to fetch and store time series metrics for a Ubiquiti Edgerouter. These metrics
can be in turn visualised (and alerted on) using Grafana.

## First use
To get the exporter up and running as well as scraped by Prometheus, there are a
few manual steps you'll need to perform:
- Make sure SNMP is enabled on your Edgerouter and the community string is set
- Modify `.edgerouter.auth.community` in `snmp.yml` to match your community
  string
- Modify `.scrape_configs.0.static_configs.0.targets.0` in `prometheus.yml` to
  match the IP address of your Edgerouter

Once these steps are complete, you can use `docker-compose up` to spin up the
test environment. To test the exporter directly without using Prometheus Server,
use the following command:
```
EDGEROUTER=192.168.1.1 # or whatever your Edgerouter's IP address is
curl "http://localhost:9116/snmp?target=${EDGEROUTER_IP}&module=edgerouter"
```

## Test environment
`docker-compose.yml` in conjunction with `snmp.yml` and `prometheus.yml`
describe how the pieces (SNMP exporter, Prometheus server, Edgerouter) are meant
to interact with one another. Follow the above instructions to get this up and
running properly. Adding a Grafana server to this spec would be trivial.

## Adding metrics
Available metrics are detailed and stored directly on a given Edgerouter, in the
`/usr/share/snmp/mibs/` directory. The ones listed in `generator.yml` were just
those I found most useful when looking through these mib files, it's perfectly
easy, if time consuming, to fetch these mib files and implement extra metrics by
adding them to the  `walk` list in `generator.yml`. Then use the config
generator at <https://github.com/prometheus/snmp_exporter/tree/master/generator>
in conjunction with the `mibs/` directory to generate a new `snmp.yml` file.

