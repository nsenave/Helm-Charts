# Massive Attack Helm Chart

Helm chart to deploy Massive Attack UI and API from the chart proposed by Bitami

This chart is not fully generic but we tried to be as less specific as possible

## Environment values :

Environnement values are saved in a configMap both for ui and api. They came from the values.yaml file.

### In case of ui values :

```yaml
ui:
  env:
    key: values
```

### API environment values :

```yaml
api:
  env:
    key: values
```

## LivenessProb and ReadinessProb :

### API :

This point is visibled in the `api\deployment.yaml`. The choice of values must be perfected.

```yaml
livenessProbe:
  failureThreshold: 3
  httpGet:
    path: /api/healthcheck
    port: http
    scheme: HTTP
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 2
readinessProbe:
  failureThreshold: 3
  httpGet:
    path: /api/healthcheck
    port: http
    scheme: HTTP
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 5
startupProbe:
  failureThreshold: 30
  httpGet:
    path: /api/healthcheck
    port: http
    scheme: HTTP
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 1
```

### UI:

UI prob's are the classic one automaticaly generated (by `helm create`)

```yaml
livenessProbe:
  httpGet:
    path: /
    port: http
readinessProbe:
  httpGet:
    path: /
    port: http
```

## Metrics :construction_worker: 

This part is still in progress.

It's possible to enable metric for the api. It is not finished and some changes must be needed. The aim is to connect a prometheus operator.

See `api/metrics-svc.yaml` and `api/servicemonitor.yaml` and `values.yaml` in the `api.metrics` block.
