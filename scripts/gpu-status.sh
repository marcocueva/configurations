#!/bin/bash
# Query GPU utilization and temperature
GPU_DATA=$(nvidia-smi --query-gpu=utilization.gpu,temperature.gpu --format=csv,noheader,nounits)

# Parse the CSV output (format: utilization,temperature)
IFS=', ' read -r UTIL TEMP <<< "$GPU_DATA"

# Output the result for i3bar
echo "GPU: ${UTIL}% | ${TEMP}°C"
