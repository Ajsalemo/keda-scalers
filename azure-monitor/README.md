# azure-monitor
General usage of a [KEDA Azure-Monitor](https://keda.sh/docs/2.18/scalers/azure-monitor) scaler using a ScaledObject.

## Troubleshooting
### The client 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' with object id 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' does not have authorization to perform action 'Microsoft.Insights/metrics/read' over scope '/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/some-rg/providers/Microsoft.App/jobs/some-job/providers/Microsoft.Insights' or the scope is invalid
Make sure the Service Principal used has "Microsoft.Insights/metrics/read" access over atleast the subscription scope

### Failed to find metric configuration for provider

```
400 Bad Request\nERROR CODE: BadRequest\n--------------------------------------------------------------------------------\n{\n  \"code\": \"BadRequest\",\n  \"message\": \"Failed to find metric configuration for provider: Microsoft.App, resource Type: jobs, metric: executionName, Valid metrics: Executions,UsageNanoCores,UsageBytes,RequestedBytes,RequestedCores,RestartCount,TxBytes,RxBytes
```

The metric provided to `metricName` doesn't exist on the Resource Provider

### got metric result for azMetricRequest and azMetricRequest.Aggregation without timeseries
Closest/relevant thread I've seen is this unanswered one: [Azure Monitor scaler stops to retrieve any external metrics and does not auto-recover - error getting azure monitor metric ActiveMessages](https://github.com/kedacore/keda/issues/2397)

After redeploying a change to the `ScaledObject` (**not** completely recreated), this moved past the below error eventually

```
ERROR	scale_handler	error getting scale decision	{"scaledObject.Namespace": "default", "scaledObject.Name": "azure-monitor-scaler", "scaler": "azureMonitorScaler", "error": "got metric result for azMetricRequest.ResourceProviderNamespace/azMetricRequest.MetricName and aggregate type azMetricRequest.Aggregation without timeseries"
```

### error parsing azure monitor metadata: missing required parameter
Self-explanatory. A required parameter is missing. See [Azure Monitor | KEDA](https://keda.sh/docs/2.18/scalers/azure-monitor) for required ones.