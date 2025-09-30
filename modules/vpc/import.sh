#!/bin/bash

REGION="sa-east-1"
# Get the list of VPC IDs
vpc=$(aws ec2 describe-vpcs --query 'Vpcs[*].VpcId' --output text --region=$REGION)
subnets=$(aws ec2 describe-subnets --query 'Subnets[*].SubnetId' --output text --region=$REGION |tr '\t' '\n')
rts=$(aws ec2 describe-route-tables --query 'RouteTables[*].RouteTableId' --output text --region=$REGION |tr '\t' '\n')
igws=$(aws ec2 describe-internet-gateways --query 'InternetGateways[*].InternetGatewayId' --output text --region=$REGION |tr '\t' '\n')
rt_associations=$(aws ec2 describe-route-tables --route-table-ids $rt --query 'RouteTables[0].Associations[*].RouteTableAssociationId' --output text --region=$REGION |tr '\t' '\n')

# # Import the VPC into the Terraform state
terraform import module.vpc.aws_vpc.this $vpc

# # Import each subnet into the Terraform state
for subnet in $subnets; do
    terraform import module.vpc.aws_subnet.this[\"$subnet\"] $subnet
done

# # Import each route table into the Terraform state
for rt in $rts; do
    terraform import module.vpc.aws_route_table.this[\"$rt\"] $rt
done

# Import each internet gateway into the Terraform state
for igw in $igws; do
    terraform import module.vpc.aws_internet_gateway.this[\"$igw\"] $igw
done