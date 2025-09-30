resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "this" {
  for_each          = var.subnets
  vpc_id            = each.value.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = lookup(each.value, "map_public_ip_on_launch", false)
}

resource "aws_route_table" "this" {
  for_each = var.route_tables
  vpc_id   = each.value.vpc_id 
}

resource "aws_internet_gateway" "this" {
  for_each = var.igws
  vpc_id   = each.value.vpc_id
}