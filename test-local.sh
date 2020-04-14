#!/usr/bin/env bash

export AWS_ACCESS_KEY_ID=noop
export AWS_SECRET_ACCESS_KEY=noop
export AWS_REGION=eu-west-2

export DYNAMO_ENDPOINT=http://localhost:4569

SCHEMA_DIR=./schema
for ENTRY in "$SCHEMA_DIR"/*.json
do
  if [ -f "$ENTRY" ];then
    FILENAME=$(basename -- "$ENTRY")
    FILENAME="${FILENAME%.*}"

    KEY="$(echo "${FILENAME}_TABLE" | awk '{print toupper($0)}')"
    KEY=$(echo "$KEY" | sed 's/.*BUILD\.//')
    KEY=$(echo "$KEY" | tr '.' '_')

    export "$KEY"="$FILENAME"
    echo "Exported tablename : $KEY"
  fi
done

go test ./... -cover -coverprofile=cover.out
#go test ./... -cover -coverprofile=cover.out && go tool cover -html=cover.out
