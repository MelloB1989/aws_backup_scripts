#!/bin/bash

# Directory to store backups
backup_dir="./dynamodb_backups"
mkdir -p $backup_dir

# List all DynamoDB tables
tables=$(aws dynamodb list-tables --output text --query 'TableNames[*]')

# Loop through each table and create a local backup
for table in $tables; do
    echo "Backing up table: $table"
    aws dynamodb scan --table-name $table --output json > "${backup_dir}/${table}_backup_$(date +%Y-%m-%d).json"
done

echo "Backup completed. Files are stored in $backup_dir"
