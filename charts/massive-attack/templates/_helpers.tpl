{{/*
Expand the name of the chart.
*/}}


{{- define "massive-attack.api.name" -}}
{{- .Values.api.nameOverride | default (printf "-%s-api" .Chart.Name ) }}
{{- end }}

{{- define "massive-attack.ui.name" -}}
{{- .Values.ui.nameOverride | default (printf "-%s-ui" .Chart.Name ) }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}

{{- define "massive-attack.api.fullname" -}}
{{- if .Values.api.fullnameOverride }}
{{- .Values.api.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.api.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "massive-attack.ui.fullname" -}}
{{- if .Values.ui.fullnameOverride }}
{{- .Values.ui.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.ui.nameOverride }}
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
{{- define "massive-attack.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "massive-attack.api.chart" -}}
{{- printf "massive-attack-api" -}}
{{- end -}}

{{- define "massive-attack.ui.chart" -}}
{{- printf "massive-attack-ui" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "massive-attack.namespace" -}}
    {{- print .Release.Namespace -}}
{{- end -}}
{{- define "massive-attack.api.serviceMonitor.namespace" -}}
    {{- if .Values.api.metrics.serviceMonitor.namespace -}}
        {{- print .Values.api.metrics.serviceMonitor.namespace -}}
    {{- else -}}
        {{- include "massive-attack.namespace" . -}}
    {{- end }}
{{- end -}}

{{/*
Common labels
*/}}

{{- define "massive-attack.api.labels" -}}
helm.sh/chart: {{ include "massive-attack.api.chart" . }}
{{ include "massive-attack.api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "massive-attack.ui.labels" -}}
helm.sh/chart: {{ include "massive-attack.ui.chart" . }}
{{ include "massive-attack.ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}

{{- define "massive-attack.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "massive-attack.api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "massive-attack.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "massive-attack.ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "massive-attack.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "massive-attack.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "massive-attack.ui.serviceAccountName" -}}
{{- if .Values.ui.serviceAccount.create }}
{{- default (include "massive-attack.ui.fullname" .) .Values.ui.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ui.serviceAccount.name }}
{{- end }}
{{- end }}
