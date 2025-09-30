variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

### S3 Module Variables ###
variable "bucket_names" {
  type = list(string)
}

variable "country" {
  type = string
}

variable "project" {
  type = string
}

variable "platform" {
  type = string
}

### IAM Module Variables ###
variable "iam_roles" {
  type = set(string)
}

variable "setup_id" {
  type = string
}

variable "setup_type" {
  type = string
}

variable "setup_version" {
  type = string
}

### CloudWatch Alarms Module Variables ###
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

### VPC Module Variables ###
variable "vpc_cidr" {
  type = string
}

variable "subnets" {
  type = map(object({
    vpc_id            = string
    cidr_block        = string
    availability_zone = string
    map_public_ip_on_launch = optional(bool, false)
  }))
}

variable "route_tables" {
  type = map(object({
    vpc_id = string
  }))
}

variable "igws" {
  type = map(object({
    vpc_id = string
  }))
}