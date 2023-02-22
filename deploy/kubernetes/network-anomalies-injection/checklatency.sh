#!/bin/bash

while true; do
  # Get the current time
  timestamp=$(date +%s)

  # Measure latency and packet loss to a specified target using mtr
  mtr_output=$(mtr google.com)

  # Parse the mtr output to extract the average latency and packet loss
  latency=$(echo "$mtr_output" | awk 'NR==2 {print $7}')
  packet_loss=$(echo "$mtr_output" | awk 'NR==2 {print $10}' | sed 's/%//g')

  # Log the results to a file
  echo "$timestamp,$latency,$packet_loss" >> /var/log/network_status.log

  # Sleep for a specified interval
  sleep 60
done
