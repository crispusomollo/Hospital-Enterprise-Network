#!/bin/bash

# Simple network health check script for cron
# Sends alert to Zabbix trapper if something is wrong

ZBX_SERVER="10.10.20.5"
ZBX_HOSTNAME="HQ-CORE-SW"

# Targets to check
TARGETS=(
  "10.10.20.10"  # EMR Server
  "10.10.30.1"   # Core SVI
  "8.8.8.8"      # Internet reachability
)

for target in "${TARGETS[@]}"; do
  ping -c1 -W1 "$target" >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    /usr/bin/zabbix_sender -z $ZBX_SERVER -s "$ZBX_HOSTNAME" -k network.health -o "FAIL:$target"
  fi
done

