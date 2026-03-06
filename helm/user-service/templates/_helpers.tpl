{{- define "user-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "user-service.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "user-service.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

