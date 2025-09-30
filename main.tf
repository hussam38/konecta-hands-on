terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = var.region
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

provider "aws" {
  region = "sa-east-1"
  alias  = "sa_east_1"
}

module "s3" {
  source       = "./modules/s3"
  bucket_names = var.bucket_names
  country      = var.country
  project      = var.project
  platform     = var.platform
}

module "s3_east" {
  source = "./modules/s3"
  providers = {
    aws = aws.us_east_1
  }
  bucket_names = [
    "cf-templates-1r5e4ovoteh3v-us-east-1"
  ]
  country  = var.country
  project  = var.project
  platform = var.platform
}

module "iam" {
  source        = "./modules/iam"
  iam_roles     = var.iam_roles
  setup_id      = var.setup_id
  setup_type    = var.setup_type
  setup_version = var.setup_version
}

module "cloudwatch_alarms" {
  source            = "./modules/cloudwatch-alarms"
  cloudwatch_alarms = var.cloudwatch_alarms
}

module "vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.sa_east_1
  }
  vpc_cidr = var.vpc_cidr
  subnets  = var.subnets
  route_tables = var.route_tables
  igws     = var.igws
}