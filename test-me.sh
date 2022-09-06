#!/usr/bin/env bash
set -euo pipefail
action=${1}
delay=${2}
exitCode=${3}
insecureValue=${INSECURE_VALUE:-default}

jsonOut=$(jq -n \
  --arg action ${action} \
  --arg delay ${delay} \
  --arg exitStatus ${exitCode} \
  --arg insecureValue ${insecureValue} \
  '{"config": { "action":$action, "parameters":{"delay":$delay|tonumber, "exitStatus":$exitStatus|tonumber }}, "credentials": {"insecureValue":$insecureValue}}')
echo ${jsonOut} > state.json
sleep ${delay}
echo ${jsonOut} | jq .
exit ${exitCode}