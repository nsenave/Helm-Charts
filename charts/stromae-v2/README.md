# Stromae V2 Helm Chart 

Helm chart to deploy Stromae UI, Queen Back Office (Queen and Stromae as the same Back Office) and Postgres databasefrom the chart proposed by Bitami


## To improve 

This chart is not fully generic but we tried to be as less specific as possible

### Environment values :

Environnement values are saved in a configMap both for ui and api. They came from the values.yaml file.

In case of ui values : 

```yaml
ui:
  env:
    key: values
```

and api :

```yaml
api:
  env:
    key: values
```

Environnement values concerning the database such as host, schema, password and username are already pass to postgres. So we decided to add the specifique key in the configmap-api.