# Geostreams Helm Charts

Launches the geostreams API container and a postgresql instance. Depends on bitnami postgresql helm chart.

Start with `helm upgrade -n geostreams --install geostreams . --values cinet-values.yaml`. 

Stop with `helm uninstall geostreams`.

To pull images from hub.ncsa.illinois.edu. You will have to register a secret in kubernetes with the api token for the 
robot account. To do that run:

```
kubectl create secret docker-registry regcred 
 --docker-server='hub.ncsa.illinois.edu' 
 --docker-username='robot$github-geostreams' 
 --docker-password='ROBOT_PASSWORD_HERE' 
 --docker-email='YOUR_EMAIL_HERE' --namespace=default
```
This will create a secret called `regcred` (you can change the name) which is referred to in `imagePullSecrets` in `values.yaml`.

Files modified on top of the helm boilerplate:

`teplates/configmap.yaml` creates the application.conf for the geostreams-api Play application.

`values.yml` uses the `postgresql.initdbScripts` to setup the postgresql schema at startup (see bottom of file).

`helpers.tpl` includes a snippet for creating the postgresql connection url based on the postgresql helm settings.

## TODO

- Add github action to release to NCSA Opensource charts.
- Find a better way to include the SQL setup script.