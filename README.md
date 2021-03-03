# Ansible Role: ansible-apps_gobetween


## Description

[![Build Status](https://travis-ci.com/lotusnoir/ansible-apps_gobetween.svg?branch=master?style=flat)](https://travis-ci.com/lotusnoir/ansible-apps_gobetween)
[![License](https://img.shields.io/badge/license-Apache--2.0-brightgreen?style=flat)](https://opensource.org/licenses/Apache-2.0)
[![Ansible Role](https://img.shields.io/badge/galaxy-apps_gobetween-purple?style=flat)](https://galaxy.ansible.com/lotusnoir/apps_gobetween)
![GitHub repo size](https://img.shields.io/github/repo-size/lotusnoir/ansible-apps_gobetween?color=orange&style=flat)
![Ansible Quality Score](https://img.shields.io/ansible/quality/52300)
[![downloads](https://img.shields.io/ansible/role/d/52300)](https://galaxy.ansible.com/lotusnoir/apps_gobetween)
[![Version](https://img.shields.io/github/release/lotusnoir/ansible-apps_gobetween.svg)](https://github.com/lotusnoir/ansible-apps_gobetween/releases/)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=lotusnoir_ansible-apps_gobetween&metric=alert_status)](https://sonarcloud.io/dashboard?id=lotusnoir_ansible-apps_gobetween)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=lotusnoir_ansible-apps_gobetween&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=lotusnoir_ansible-apps_gobetween)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=lotusnoir_ansible-apps_gobetween&metric=reliability_rating)](https://sonarcloud.io/dashboard?id=lotusnoir_ansible-apps_gobetween)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=lotusnoir_ansible-apps_gobetween&metric=security_rating)](https://sonarcloud.io/dashboard?id=lotusnoir_ansible-apps_gobetween)

Deploy [gobetween](https://github.com/yyyar/gobetween/releases) load balancer system using ansible.


## Installation steps

1. Create user / group / directories
2. Install binary from repo or from given path
3. Configure config file
4. Configure healthchecks (optional)


## Role variables

| Name                          | Default Value            | Description                        |
| ----------------------------- | ------------------------ | -----------------------------------|
| `gobetween_version`           | 0.8.0                    | gobetween version |
| `gobetween_binary_file`       | /usr/local/bin/gobetween | gobetween binary name|
| `gobetween_install_dir`       | /etc/gobetween           | Config files path |
| `gobetween_install_local`     | false                    | allow to install a local version |
| `gobetween_local_file`        | ""                       | path to local gobetween binary file |
| `gobetween_log_file`          | /var/log/gobetween.log   | path for the log file|
| `gobetween_healthcheck_user`  | gobetween                | healthcheck ssh user to connect targets|
| `gobetween_target_servers`    | ["localhost"]            | |
| `gobetween_log_level`         | info                     | log level |
| `gobetween_profiler`          | false                    | enable profiler endpoint |
| `gobetween_profiler_port`     | 6060                     | profiler endpoint port|
| `gobetween_api`               | false                    | enable api endpoint |
| `gobetween_api_port`          | 8888                     | api endpoint port |
| `gobetween_api_cors`          | false                    | enable api cors |
| `gobetween_metrics`           | true                     | expose prometheus metrics endpoint |
| `gobetween_metrics_port`      | 9101                     | metrics endpoint port |
| `gobetween_targets`           | {}                       | servers to configure on gobetween.toml |
| `gobetween_healthcheck`       | []                       | configure healthcheck for each target |


## Playbook example

	---
	- hosts: apps_gobetween
	  become: yes
	  become_method: sudo
	  gather_facts: yes
	  roles:
	    - role: ansible-apps_gobetween
	  vars:
	    gobetween_version: "0.8.0"
	    gobetween_install_dir: /etc/gobetween
        gobetween_target_servers: "{{ groups['logs_servers'] }}"
        gobetween_targets:
          - {name: syslog, port: 514, protocol: udp, balance: roundrobin, transparent: true, targets: "{{ gobetween_target_servers }}" }
          - name: snmp
            port: 162
            protocol: udp
            balance: roundrobin
            transparent: true
            max_reponses: 10
            max_requests: 1
            targets: "{{ gobetween_target_servers }}"
	  environment: 
	    http_proxy: "{{ http_proxy }}"
	    https_proxy: "{{ https_proxy }}"
	    no_proxy: "{{ no_proxy }}


## Metrics

Metrics are exposed in prometheus format directly from the application with gobetween_metrics: enable on gobetween_metrics_port


## Grafana Dashboard

A sample dashboard is available here: [https://grafana.com/grafana/dashboards/13571](https://grafana.com/grafana/dashboards/13571)


## License

This project is licensed under Apache License. See [LICENSE](/LICENSE) for more details.
