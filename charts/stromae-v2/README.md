# Stromae V2 Helm Chart

Helm chart to deploy Stromae UI, Queen Back Office (Queen and Stromae as the same Back Office) and Postgres databasefrom the chart proposed by Bitami


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

Environnement values concerning the database such as host, schema, password and username are already pass to postgres. So we decided to add the specifique key in the configmap-api. We are aware that this point needs to be improved

## LivenessProb and ReadinessProb :

### API :

This point is visibled in the `deployment-api.yaml`. The choice of values must be perfected and a startupProb could be usefull.

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
