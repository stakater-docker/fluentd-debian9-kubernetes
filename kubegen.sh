#!/bin/bash
set -e

/kubegen/kube-gen -watch -type pods -wait 2s:3s -post-cmd '/fluentd/etc/scripts/kill-processes.sh fluentd' /fluentd/etc/template/${FLUENTD_CONF_TEMPLATE} /fluentd/etc/${FLUENTD_CONF}