{{- define "kong.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kong.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "kong.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

