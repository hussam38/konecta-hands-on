variable "bucket_names" {
  description = "List of S3 bucket names to create"
  type        = list(string)
}

variable "country" {
  description = "Country tag for the S3 buckets"
  type        = string
}

variable "project" {
  description = "Project tag for the S3 buckets"
  type        = string
}

variable "platform" {
  description = "Platform tag for the S3 buckets"
  type        = string
}