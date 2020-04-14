#!/usr/bin/env bash

./localstack-down.sh
./localstack.sh
./localstack-dynamodb-tables.sh