#!/usr/bin/dumb-init /bin/sh

set -e

if [ -z ${FLUENT_ELASTICSEARCH_USER} ] ; then
   sed -i  '/FLUENT_ELASTICSEARCH_USER/d' ${FLUENTD_CONF_PATH}/${FLUENTD_CONF}
fi

if [ -z ${FLUENT_ELASTICSEARCH_PASSWORD} ] ; then
   sed -i  '/FLUENT_ELASTICSEARCH_PASSWORD/d' ${FLUENTD_CONF_PATH}/${FLUENTD_CONF}
fi

echo "Hello"

fluentd -c ${FLUENTD_CONF_PATH}/${FLUENTD_CONF} -p /fluentd/plugins --gemfile /fluentd/Gemfile ${FLUENTD_OPT}