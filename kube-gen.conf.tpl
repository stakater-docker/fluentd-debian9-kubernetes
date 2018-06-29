# This template will be an input to kube-gen

@include match/fluentd.conf

@include source/kubernetes.conf
@include source/minion.conf
@include source/startupscript.conf
@include source/docker.conf
@include source/etcd.conf
@include source/kubelet.conf
@include source/kube-proxy.conf
@include source/kube-apiserver.conf
@include source/kube-controller-manager.conf
@include source/kube-scheduler.conf
@include source/kube-rescheduler.conf
@include source/glbc.conf
@include source/cluster-autoscaler.conf
@include source/kube-apiserver-audit.conf
@include source/systemd-kubelet.conf
@include source/systemd-docker.conf
@include source/systemd-bootkube.conf

@include filter/kubernetes-metadata.conf

@include match/elasticsearch.conf