#!/bin/bash

START="# >>> IAM_ROLES"
END="# <<< IAM_ROLES"
POLICY_DIR="modules/iam/policies"
# Get the list of IAM roles and save to roles.txt
aws iam list-roles --query 'Roles[*].RoleName' --output text --no-paginate | tr '\t' '\n' > modules/iam/roles.txt

# Add IAM roles to vars.auto.tfvars (pick only first 10 roles for time)
{
  echo 'iam_roles = ['
  head -n 10 modules/iam/roles.txt | sed 's/.*/  "&",/'
  echo ']'
} > tmp_roles.tfvars

# To avoid duplicates of iam_roles, remove existing block between markers if they exist
if grep -q "$START" vars.auto.tfvars && grep -q "$END" vars.auto.tfvars; then
  sed -i "/$START/,/$END/{//!d;}" vars.auto.tfvars
  sed -i "/$START/r tmp_roles.tfvars" vars.auto.tfvars
else
  # If markers don't exist, append everything at the end
  {
    echo ""
    echo "$START"
    cat tmp_roles.tfvars
    echo "$END"
  } >> vars.auto.tfvars
fi

# Clean up temporary file
rm tmp_roles.tfvars

# Create policies directory if it doesn't exist
if [ ! -d "$POLICY_DIR" ]; then
    echo "Creating directory: $POLICY_DIR"
    mkdir -p "$POLICY_DIR"
    head -n 10 modules/iam/roles.txt | while read -r role; do
    if [ -n "$role" ]; then
        echo "Exporting trust policy for $role"
        aws iam get-role --role-name "$role" \
        --query 'Role.AssumeRolePolicyDocument' \
        --output json > "$POLICY_DIR/${role}.json"
    fi
    done
fi

#Import each IAM role into Terraform state
head -n 10 modules/iam/roles.txt | while read -r role; do
  if [ -n "$role" ]; then
    echo "Importing role: $role"
    terraform import "module.iam.aws_iam_role.this[\"$role\"]" "$role"
  fi
done