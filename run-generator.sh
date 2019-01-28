#!/bin/bash -eu

rm -rf tmp && mkdir -p tmp
cp generator.yml tmp/

docker run -ti \
  -v ${PATH_TO_MIBS}:/root/.snmp/mibs \
  -v $PWD/tmp/:/opt/ \
  snmp-generator generate

