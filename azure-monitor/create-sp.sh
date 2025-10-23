#!/bin/bash
# Helper script to create a service principal with Monitoring Reader role
# This is needed for KEDA Azure Monitor scaler to read metrics or else you get a message like:
# The client 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' with object id 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' does not have authorization to perform action 'Microsoft.Insights/metrics/read' over scope '/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/some-rg/providers/Microsoft.App/jobs/some-job/providers/Microsoft.Insights' or the scope is invalid
az ad sp create-for-rbac --name "some-sp" --role "Monitoring Reader" --scopes "subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx"
az ad sp create --id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# Use this to create an assignment for an existing service principal - or - if the first command fails
az role assignment create \
  --assignee "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" \
  --role "Monitoring Reader" \
  --scope "subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxx"

az ad sp show --id "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

