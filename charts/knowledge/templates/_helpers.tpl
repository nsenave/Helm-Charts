{{/*
Expand the name of the chart.
*/}}


{{- define "knowledge.api.name" -}}
{{- .Values.api.nameOverride | default (printf "%s-api" .Chart.Name ) }}
{{- end }}

{{- define "knowledge.ui.name" -}}
{{- .Values.ui.nameOverride | default (printf "%s-ui" .Chart.Name ) }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}

{{- define "knowledge.api.fullname" -}}
{{- if .Values.api.fullnameOverride }}
{{- .Values.api.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (printf "%s-api" .Chart.Name ) .Values.api.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "knowledge.ui.fullname" -}}
{{- if .Values.ui.fullnameOverride }}
{{- .Values.ui.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (printf "%s-ui" .Chart.Name ) .Values.ui.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{- define "knowledge.mongodb.fullname" -}}
{{- if .Values.mongodb.fullnameOverride -}}
{{- .Values.mongodb.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.mongodb.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "knowledge.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "knowledge.api.chart" -}}
{{- printf "knowledge-api" -}}
{{- end -}}

{{- define "knowledge.ui.chart" -}}
{{- printf "knowledge-ui" -}}
{{- end -}}

{{/*
Common labels
*/}}

{{- define "knowledge.api.labels" -}}
helm.sh/chart: {{ include "knowledge.api.chart" . }}
{{ include "knowledge.api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "knowledge.ui.labels" -}}
helm.sh/chart: {{ include "knowledge.ui.chart" . }}
{{ include "knowledge.ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}

{{- define "knowledge.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "knowledge.api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "knowledge.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "knowledge.ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{/*
Create the name of the service account to use
*/}}
{{- define "knowledge.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create }}
{{- default (include "knowledge.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.api.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "knowledge.ui.serviceAccountName" -}}
{{- if .Values.ui.serviceAccount.create }}
{{- default (include "knowledge.ui.fullname" .) .Values.ui.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.ui.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create list of mongo host
*/}}
{{- define "mongoList" -}}
{{- $replicaCount := int .Values.mongodb.replicaCount }}
{{- $portNumber := int .Values.mongodb.service.ports.mongodb }}
{{- $fullname := include "knowledge.mongodb.fullname" . }}
{{- $mongoList := list }}
{{- range $e, $i := until $replicaCount }}
{{- $mongoList = append $mongoList (printf "%s-%d.%s-headless:%d" $fullname $i $fullname $portNumber) }}
{{- end }}
{{- printf "%s"  (join "," $mongoList) -}}
{{- end }}