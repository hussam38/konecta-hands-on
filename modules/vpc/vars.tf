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
  default = {}
}