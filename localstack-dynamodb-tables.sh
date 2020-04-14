#!/bin/bash

# deletes, if exists, and creates table defined in the SCHEMA_DIR
SCHEMA_DIR=./schema
DYNAMO_PORT=4569

for ENTRY in "$SCHEMA_DIR"/*.json
do
  if [ -f "$ENTRY" ];then
    FILENAME=$(basename -- "$ENTRY")
    # expected filename pattern of <environment>.<tablename>.json, e.g. build.testable.json
    FILENAME="${FILENAME%.*}"

    echo "Deleting table ${FILENAME}"
    aws --endpoint-url=http://localhost:"$DYNAMO_PORT" dynamodb delete-table --table-name "${FILENAME}"

    echo "Create table from config ${ENTRY}"
    aws --endpoint-url=http://localhost:"$DYNAMO_PORT" dynamodb create-table --cli-input-json file://"$ENTRY"
  fi
done