{{- define "gitlab-runner-hetzner-autoscale.resname" -}}
{{- if $.Values.resname -}}
{{- $.Values.resname | trunc 48 | trimSuffix "-" -}}
{{- else -}}
{{- $.Release.Name | trunc 48 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "gitlab-runner-hetzner-autoscale.name" -}}
{{- default $.Chart.Name $.Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label. */}}
{{- define "gitlab-runner-hetzner-autoscale.chart" -}}
{{- printf "%s-%s" $.Chart.Name $.Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{ define "gitlab-runner-hetzner-autoscale.labels" }}
app: {{ template "gitlab-runner-hetzner-autoscale.name" $ }}
chart: {{ template "gitlab-runner-hetzner-autoscale.chart" $ }}
release: {{ $.Release.Name }}
heritage: {{ $.Release.Service }}
{{- end -}}

{{ define "gitlab-runner-hetzner-autoscale.labels-selector" }}
app: {{ template "gitlab-runner-hetzner-autoscale.name" $ }}
release: {{ $.Release.Name }}
{{- end -}}
