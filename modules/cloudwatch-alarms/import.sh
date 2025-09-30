#!/bin/bash

RESOURCE="aws_cloudwatch_metric_alarm.this"
REGION="eu-west-1"

# Get alarms from eu-west1-region
alarms=$(aws cloudwatch describe-alarms --query 'MetricAlarms[*].AlarmName' --output text --region=$REGION |tr '\t' '\n')

for alarm in $alarms; do
  echo "Importing alarm: $alarm"
  terraform import "module.cloudwatch_alarms.${RESOURCE}[\"$alarm\"]" "$alarm"
done