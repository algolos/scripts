#!/bin/bash

# This script returns logs of all pods in namespace
# Set the namespace
NAMESPACE="$1"

# Get all pod names in the specified namespace
PODS=$(kubectl get pods -n $NAMESPACE -o jsonpath='{.items[*].metadata.name}')

touch "${NAMESPACE}-logs.log"
# Loop through each pod and get its logs
for POD in $PODS
do
    echo "Logs for $POD:" >> "${NAMESPACE}-logs.log"
    kubectl logs $POD -n $NAMESPACE >> "${NAMESPACE}-logs.log"
    echo "-----------------------------------" >> "${NAMESPACE}-logs.log"
done
