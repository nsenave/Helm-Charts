{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "queen.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "queen.ui.name" -}}
{{- printf "%s-%s" (include "queen.name" .) .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "queen.api.name" -}}
{{- printf "%s-%s" (include "queen.name" .) .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "queen.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "queen.ui.fullname" -}}
{{- printf "%s-%s" (include "queen.fullname" .) .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "queen.api.fullname" -}}
{{- printf "%s-%s" (include "queen.fullname" .) .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "queen.chart" -}}
{{- printf "queen" -}}
{{- end -}}

{{- define "queen.api.chart" -}}
{{- printf "queen-api" -}}
{{- end -}}

{{- define "queen.ui.chart" -}}
{{- printf "queen-ui" -}}
{{- end -}}


{{/*Common labels*/}}

{{- define "queen.labels" -}}
helm.sh/chart: {{ include "queen.chart" . }}
{{ include "queen.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "queen.api.labels" -}}
helm.sh/chart: {{ include "queen.api.chart" . }}
{{ include "queen.api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "queen.ui.labels" -}}
helm.sh/chart: {{ include "queen.ui.chart" . }}
{{ include "queen.ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*Selector labels*/}}
{{- define "queen.selectorLabels" -}}
app.kubernetes.io/name: {{ include "queen.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{- define "queen.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "queen.api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "queen.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "queen.ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*Create the name of the service account to use*/}}

{{- define "queen.api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "queen.api.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "queen.ui.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "queen.ui.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}