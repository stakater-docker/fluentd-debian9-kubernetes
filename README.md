# dockerfile-fluentd-debian9-kubernetes
debian9 (stretch) --> fluentd --> kubernetes | Dockerfile of fluentd atop Debian 9 Stretch to run on kubernetes

[![Release](https://img.shields.io/github/release/stakater-docker/fluentd-debian9-kubernetes.svg?style=flat-square)](https://github.com/stakater-docker/fluentd-debian9-kubernetes/releases/latest)
[![GitHub tag](https://img.shields.io/github/tag/stakater/fluentd-debian9-kubernetes.svg?style=flat-square)](https://github.com/stakater-docker/fluentd-debian9-kubernetes/releases/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/stakater/fluentd-debian9-kubernetes.svg?style=flat-square)](https://hub.docker.com/r/stakater/fluentd-debian9-kubernetes)
[![Docker Stars](https://img.shields.io/docker/stars/stakater/fluentd-debian9-kubernetes.svg?style=flat-square)](https://hub.docker.com/r/stakater-docker/fluentd-debian9-kubernetes)
[![MicroBadger Size](https://img.shields.io/microbadger/image-size/stakater/fluentd-debian9-kubernetes.svg?style=flat-square)](https://microbadger.com/images/stakater-docker/fluentd-debian9-kubernetes)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/_/httpd.svg?style=flat-square)](https://microbadger.com/images/stakater-docker/fluentd-debian9-kubernetes)
[![license](https://img.shields.io/github/license/stakater-docker/fluentd-debian9-kubernetes.svg?style=flat-square)](LICENSE)

## Acknowledgement

- https://github.com/fluent/fluentd-kubernetes-daemonset

## Why this another fluentd image?

- We have custom plugins like slack plugin that we want to use with fluentd, which aren't available in the original image
- We've updated the dockerfile to allow custom config paths via environment variables
- We've bundled a couple of source, filters and matches with this image that we want to use with kubernetes

## What it contains

### Source

The image contains a lot of predefined sources related to kubernetes, docker and systemd. Following list contains all of them:

- cluster-autoscaler
- docker
- etcd
- glbc
- kube-apiserver-audit
- kube-apiserver
- kube-controller-manager
- kube-proxy
- kube-rescheduler
- kube-scheduler
- kubelet
- kubernetes
- minion
- startupscript
- systemd-bootkube
- systemd-docker
- systemd-kubelet

### Filter

This image only contains `kubernetes-metadata` filter for now.

### Match

We've included `elasticsearch` and `fluentd` matches in this image.

## Naming Conventions

The naming conventions for building this image are mentioned here: https://stakater.gitbook.io/stakater/docker-guidelines

## Help

**Got a question?**
File a GitHub [issue](https://github.com/stakater-docker/fluentd-debian9-kubernetes/issues), or send us an [email](mailto:stakater@gmail.com).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/https://github.com/stakater-docker/fluentd-debian9-kubernetes/issues) to report any bugs or file feature requests.

### Developing

PRs are welcome. In general, we follow the "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

NOTE: Be sure to merge the latest from "upstream" before making a pull request!

## Changelog

View our closed [Pull Requests](https://github.com/https://github.com/stakater-docker/fluentd-debian9-kubernetes/issues/pulls?q=is%3Apr+is%3Aclosed).

## License

Apache2 © [Stakater](http://stakater.com)

## About

`fluentd-debian9-kubernetes` docker is maintained by [Stakater][website]. Like it? Please let us know at <hello@stakater.com>

See [our other projects][community]
or contact us in case of professional services and queries on <hello@stakater.com>

  [website]: http://stakater.com/
  [community]: https://github.com/stakater/