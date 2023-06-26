{{/*
Expand the name of the chart.
*/}}


{{- define "platine-management.api.name" -}}
{{- .Values.api.nameOverride | default (printf "%s-api" .Chart.Name ) }}
{{- end }}

{{- define "platine-management.ui.name" -}}
{{- .Values.ui.nameOverride | default (printf "%s-ui" .Chart.Name ) }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}

{{- define "platine-management.api.fullname" -}}
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

{{- define "platine-management.ui.fullname" -}}
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

{{- define "platine-management.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride -}}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "platine-management.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "platine-management.api.chart" -}}
{{- printf "platine-management-api" -}}
{{- end -}}

{{- define "platine-management.ui.chart" -}}
{{- printf "platine-management-ui" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "platine-management.namespace" -}}
    {{- print .Release.Namespace -}}
{{- end -}}
{{- define "platine-management.api.serviceMonitor.namespace" -}}
    {{- if .Values.api.metrics.serviceMonitor.namespace -}}
        {{- print .Values.api.metrics.serviceMonitor.namespace -}}
    {{- else -}}
        {{- include "platine-management.namespace" . -}}
    {{- end }}
{{- end -}}

{{/*
Common labels
*/}}

{{- define "platine-management.api.labels" -}}
helm.sh/chart: {{ include "platine-management.api.chart" . }}
{{ include "platine-management.api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "platine-management.ui.labels" -}}
helm.sh/chart: {{ include "platine-management.ui.chart" . }}
{{ include "platine-management.ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}

{{- define "platine-management.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "platine-management.api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "platine-management.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "platine-management.ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "platine-management.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "platine-management.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "platine-management.ui.serviceAccountName" -}}
{{- if .Values.ui.serviceAccount.create }}
{{- default (include "platine-management.ui.fullname" .) .Values.ui.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ui.serviceAccount.name }}
{{- end }}
{{- end }}
