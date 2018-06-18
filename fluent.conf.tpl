{{ $pods := whereExist .Pods "ObjectMeta.Annotations.fluentd_configuration" -}}

# Listen for logs on port 24224 of docker host network, as pod runs with HostNetwork: true
# (docker log driver will send to this address)
<source>
  @type forward
  port 24224
</source>

# Read kubernetes logs
<source>
  @type tail
  path /var/log/containers/*.log
  pos_file /var/log/es-containers.log.pos
  time_format %Y-%m-%dT%H:%M:%S.%N
  tag kubernetes.*
  format json
  read_from_head true
</source>

<filter kubernetes.var.log.containers.**.log>
  @type kubernetes_metadata
</filter>

{{- $target_pods := whereExist .Pods "ObjectMeta.Annotations.fluentd_configuration" -}}
{{- range $pod := $target_pods -}}
  {{/* get dockerid for the logfile */}}
  {{- $cID := trimPrefix (index $pod.Status.ContainerStatuses 0).ContainerID "docker://"}}
  {{/* parse annotation to readable config */}}
  {{- $config := first (parseJson $pod.ObjectMeta.Annotations.fluentd_configuration) }} 
  {{- range $containerConfig := $config }}
  {{- $containerName := "avc" }}
  {{- if (len $pod.Spec.Containers) eq 1 }}
  <filter kubernetes.var.log.containers.{{ $pod.ObjectMeta.Name }}_{{ $pod.ObjectMeta.Namespace }}_{{ (index $pod.Spec.Containers 0).Name }}-{{ $cID }}.log> 
  {{- else }}
  <filter kubernetes.var.log.containers.{{ $pod.ObjectMeta.Name }}_{{ $pod.ObjectMeta.Namespace }}_{{ $containerConfig.container_name }}-{{ $cID }}.log> 
  {{- end }}
    @type parser
    key_name log
    <parse>
      @type regexp
      expression {{ $containerConfig.expression }}
      time_format {{ $containerConfig.time_format }}
    </parse>
  </filter>
  {{- end }}
{{- end }} 

# Generic multiline (for docker containers)
# TODO: add multiline_end_regexp, as without that, multiline logs won't be 
# parsed by concat filter if another log doesn't come immedietly after that one
# see https://github.com/fluent-plugins-nursery/fluent-plugin-concat/issues/2
<filter **>
  @type concat
  key log
  multiline_start_regexp /^[\S]+/
  flush_interval 30s
</filter>

# Send all logs to ES
<match **>
  @type elasticsearch
  @log_level info
  include_tag_key true
  host elasticsearch.tools
  port 9200
  logstash_format true
  # For EK 6+ setup
  # logstash_prefix logs
  flush_interval 30s
  # Never wait longer than 5 minutes between retries.
  max_retry_wait 60
  # Disable the limit on the number of retries (retry forever).
  disable_retry_limit
  time_key timestamp
  reload_connections false
</match>
