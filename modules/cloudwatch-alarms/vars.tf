variable "cloudwatch_alarms" {
  type = map(object({
    metric_name         = string
    comparison_operator = string
    evaluation_periods  = number
    threshold           = number
    statistic           = string
    namespace           = string
    period              = number
    datapoints_to_alarm = number
    dimensions          = map(string)
    treat_missing_data  = optional(string)
  }))
}