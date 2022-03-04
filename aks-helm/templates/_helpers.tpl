{{/*
Expand the name of the chart.
*/}}

{{- define "<sample>.ingressannotation" -}}
kubernetes.io/ingress.class: azure/application-gateway
{{- end }}

{{- define "<sample>.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
<Explanation>
*/}}
{{- define "<sample>.fullname" -}}
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
*/}}
{{- define "<sample>.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
<Explanation>
*/}}
{{- define "<sample>.labels" -}}
helm.sh/chart: {{ include "<sample>.chart" . }}
{{ include "<sample>.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
<Explanation>
*/}}
{{- define "<sample>.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "<sample>.crdLabels" -}}
helm.sh/chart: {{ include "<sample>.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
<Explanation>
*/}}
{{- define "<sample>.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "<sample>.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
