resource "aws_cloudwatch_metric_alarm" "this" {
  for_each            = var.cloudwatch_alarms
  alarm_name          = each.key
  metric_name         = each.value.metric_name
  comparison_operator = each.value.comparison_operator
  evaluation_periods  = each.value.evaluation_periods
  threshold           = each.value.threshold
  statistic           = each.value.statistic
  namespace           = each.value.namespace
  period              = each.value.period
  datapoints_to_alarm = each.value.datapoints_to_alarm
  dimensions          = each.value.dimensions
  treat_missing_data  = lookup(each.value, "treat_missing_data", null)
}