# Geostreams Helm Charts

Launches the geostreams API container and a postgresql instance. Depends on bitnami postgresql helm chart.

Start with `helm upgrade --install geostreams .`. 

Stop with `helm uninstall geostreams`.

Files modified on top of the helm boilerplate:

`teplates/configmap.yaml` creates the application.conf for the geostreams-api Play application.

`values.yml` uses the `postgresql.initdbScripts` to setup the postgresql schema at startup (see bottom of file).

`helpers.tpl` includes a snippet for creating the postgresql connection url based on the postgresql helm settings.

## TODO

- Add frontend container.
- Add github action to release to NCSA Opensource charts.
- Find a better way to include the SQL setup script.