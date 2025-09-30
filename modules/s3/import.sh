#!/bin/bash
# Initialize variables
DEFAULT_MODULE_NAME="s3" 
US_EAST_MODULE_NAME="s3_east"    
DEFAULT_BUCKET_NAME="this"
EXCLUDE_BUCKET="cf-templates-1r5e4ovoteh3v-us-east-1"       

# Get all bucket names
read -r -a buckets <<< "$(aws s3api list-buckets --query "Buckets[].Name" --output text)"

# iterate over each bucket and import it into terraform state
for bucket in "${buckets[@]}"; do
    # us-east-1 bucket. There is only 1 bucket in this region.
    if [ "$bucket" == "$EXCLUDE_BUCKET" ]; then
        RESOURCE_ADDR="module.${US_EAST_MODULE_NAME}.aws_s3_bucket.${DEFAULT_BUCKET_NAME}[\"$bucket\"]"
        terraform import "$RESOURCE_ADDR" "$bucket"
        continue
    fi
    # all other bucket are in eu-west-1 region
    RESOURCE_ADDR="module.${DEFAULT_MODULE_NAME}.aws_s3_bucket.${DEFAULT_BUCKET_NAME}[\"$bucket\"]"
    terraform import "$RESOURCE_ADDR" "$bucket"
done
