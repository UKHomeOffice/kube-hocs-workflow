#!/bin/bash
set -euo pipefail

export KUBE_NAMESPACE=${ENVIRONMENT}
export KUBE_SERVER=${KUBE_SERVER}
export KUBE_TOKEN=${KUBE_TOKEN}
export VERSION=${VERSION}

if [[ ${KUBE_NAMESPACE} == *prod ]]
then
    export MIN_REPLICAS="2"
    export MAX_REPLICAS="6"

    export UPTIME_PERIOD="Mon-Sun 05:00-23:00 Europe/London"
else
    export MIN_REPLICAS="1"
    export MAX_REPLICAS="2"

    export UPTIME_PERIOD="Mon-Fri 08:00-18:00 Europe/London"
fi

cd kd

kd --insecure-skip-tls-verify \
   --timeout 15m \
    -f deployment.yaml \
    -f service.yaml \
    -f autoscale.yaml
