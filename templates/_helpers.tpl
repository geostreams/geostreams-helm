{{/*
Expand the name of the chart.
*/}}
{{- define "geostreams.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "geostreams.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "geostreams.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "geostreams.labels" -}}
helm.sh/chart: {{ include "geostreams.chart" . }}
{{ include "geostreams.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "geostreams.selectorLabels" -}}
app.kubernetes.io/name: {{ include "geostreams.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "geostreams.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "geostreams.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
RabbitMQ URI
*/}}
{{- define "geostreams.postgresqluri" -}}
{{- $username := default "geostreams" .Values.postgresql.postgresqlUsername -}}
{{- $password := default "geostreams" .Values.postgresql.postgresqlPassword -}}
{{- $database := default "geostreams" .Values.postgresql.postgresqlDatabase -}}
{{- $port := default 5432 .Values.postgresql.service.port -}}
{{- $server := printf "%s-postgresql" (include "geostreams.fullname" .) -}}
{{- printf "jdbc:postgresql://%s:%.f/%s?user=%s&password=%s" $server $port $database $username $password -}}
{{- end -}}
