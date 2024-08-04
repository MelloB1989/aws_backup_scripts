#!/bin/bash

# Directory to store backups
backup_dir="./appsync_backups"
mkdir -p $backup_dir

# List all AppSync APIs
apis=$(aws appsync list-graphql-apis --query 'graphqlApis[*].apiId' --output text)

# Loop through each API and create a local backup
for api in $apis; do
    echo "Backing up schema for API: $api"
    output_file="${backup_dir}/${api}_schema_$(date +%Y-%m-%d).graphql"
    aws appsync get-introspection-schema --api-id $api --format SDL $output_file
done

echo "Backup completed. Files are stored in $backup_dir"
