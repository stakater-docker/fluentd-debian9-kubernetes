FROM stakater/fluentd-debian9:1.2.2-0.0.1
LABEL maintainer="Stakater Team"
LABEL Description="Fluentd docker image atop Debian9 to run on Kubernetes"

ENV FLUENTD_CONF_TEMPLATE=fluent.conf.tpl

ARG DEBIAN_FRONTEND=noninteractive

# Do not split this into multiple RUN!
# Docker creates a layer for every RUN-Statement
# therefore an 'apt-get purge' has no effect
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
            ca-certificates \
            ruby \
 && buildDeps=" \
      make gcc g++ libc-dev \
      ruby-dev \
      wget bzip2 gnupg dirmngr \
    " \
 && apt-get install -y --no-install-recommends $buildDeps \
 && update-ca-certificates \
 && echo 'gem: --no-document' >> /etc/gemrc \
 && gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2 \
 && gem install --no-document fluent-plugin-elasticsearch -v 1.9.5 \
 && gem install --no-document fluent-plugin-prometheus -v 0.2.1 \
 && gem install --no-document fluent-plugin-concat -v 2.1.0 \
 && gem install --no-document fluent-plugin-rewrite-tag-filter -v 2.1.0 \
 && cd /tmp \
 && wget https://github.com/stakater/kube-gen/releases/download/0.3.4/kube-gen \
 && mkdir -p /kubegen/ \
 && mv /tmp/kube-gen /kubegen/kube-gen \
 && chmod +x /kubegen/kube-gen \
 && apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# Remove default conf
#RUN rm -f /fluentd/etc/*.conf

#COPY ./${FLUENTD_CONF_TEMPLATE} /fluentd/etc/template/
#COPY ./kill-processes.sh /fluentd/etc/scripts/