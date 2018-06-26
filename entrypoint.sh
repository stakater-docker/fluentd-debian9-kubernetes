#!/usr/bin/dumb-init /bin/sh

set -e

if [ -z ${FLUENT_ELASTICSEARCH_USER} ] ; then
   sed -i  '/FLUENT_ELASTICSEARCH_USER/d' /fluentd/etc/${FLUENTD_CONF}
fi

if [ -z ${FLUENT_ELASTICSEARCH_PASSWORD} ] ; then
   sed -i  '/FLUENT_ELASTICSEARCH_PASSWORD/d' /fluentd/etc/${FLUENTD_CONF}
fi

exec kube-gen -watch -type pods -wait 2s:3s -post-cmd '/fluentd/etc/scripts/fluentd-runner.sh fluentd' /fluentd/etc/template/${FLUENTD_CONF_TEMPLATE} /fluentd/etc/${FLUENTD_CONF}