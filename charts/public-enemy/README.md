# Public Enemy V2 Helm Chart

Helm chart to deploy Public Enemy UI, Public Enemy API and Postgres database from the chart proposed by Bitnami

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

Environnement values concerning the database such as host, schema, password and username are already pass to postgres. So we decided to pass them to the api throught the environement values in the `api\deployment.yaml`

## LivenessProb and ReadinessProb :

### API :

This point is visibled in the `api\deployment.yaml`. The choice of values must be perfected.

```yaml
livenessProbe:
  failureThreshold: 3
  httpGet:
    path: /actuator/health/liveness
    port: http
    scheme: HTTP
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 2
readinessProbe:
  failureThreshold: 3
  httpGet:
    path: /actuator/health/readiness
    port: http
    scheme: HTTP
  periodSeconds: 10
  successThreshold: 1
  timeoutSeconds: 5
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
