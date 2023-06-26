{{/*
Expand the name of the chart.
*/}}


{{- define "coleman-access.api.name" -}}
{{- .Values.api.nameOverride | default (printf "-%s-api" .Chart.Name ) }}
{{- end }}

{{- define "coleman-access.ui.name" -}}
{{- .Values.ui.nameOverride | default (printf "-%s-ui" .Chart.Name ) }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}

{{- define "coleman-access.api.fullname" -}}
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

{{- define "coleman-access.ui.fullname" -}}
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
{{- define "coleman-access.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "coleman-access.api.chart" -}}
{{- printf "coleman-access-api" -}}
{{- end -}}

{{- define "coleman-access.ui.chart" -}}
{{- printf "coleman-access-ui" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "coleman-access.namespace" -}}
    {{- print .Release.Namespace -}}
{{- end -}}
{{- define "coleman-access.api.serviceMonitor.namespace" -}}
    {{- if .Values.api.metrics.serviceMonitor.namespace -}}
        {{- print .Values.api.metrics.serviceMonitor.namespace -}}
    {{- else -}}
        {{- include "coleman-access.namespace" . -}}
    {{- end }}
{{- end -}}

{{/*
Common labels
*/}}

{{- define "coleman-access.api.labels" -}}
helm.sh/chart: {{ include "coleman-access.api.chart" . }}
{{ include "coleman-access.api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "coleman-access.ui.labels" -}}
helm.sh/chart: {{ include "coleman-access.ui.chart" . }}
{{ include "coleman-access.ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}

{{- define "coleman-access.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "coleman-access.api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "coleman-access.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "coleman-access.ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "coleman-access.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "coleman-access.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "coleman-access.ui.serviceAccountName" -}}
{{- if .Values.ui.serviceAccount.create }}
{{- default (include "coleman-access.ui.fullname" .) .Values.ui.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ui.serviceAccount.name }}
{{- end }}
{{- end }}
