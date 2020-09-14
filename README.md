# Ansible Role: ansible-apps_gobetween


## Description

[![Build Status](https://travis-ci.com/lotusnoir/ansible-apps_gobetween.svg?branch=master)](https://travis-ci.com/lotusnoir/ansible-apps_gobetween)[![License](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg)](https://opensource.org/licenses/MIT)[![Ansible Role](https://img.shields.io/badge/ansible%20role-apps__gobetween-blue)](https://galaxy.ansible.com/lotusnoir/ansible-apps_gobetween/)[![GitHub tag](https://img.shields.io/badge/version-latest-blue)](https://github.com/lotusnoir/ansible-apps_gobetween/tags)

Deploy [gobetween](https://github.com/yyyar/gobetween/releases) load balancer system using ansible.


## Role variables

| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `gobetween_version` | 0.8.0 | gobetween version |
| `gobetween_binary_file` | /usr/local/bin/gobetween | gobetween binary name|
| `gobetween_install_dir` | /etc/gobetween | Config files path |
| `gobetween_install_local` | false | allow to install a local version |
| `gobetween_local_file` | "" | path to local gobetween binary file |
| `ulimit` | 65536 | ulimit file limit|
| `gobetween_log_path` | /var/log/gobetween.log | log path|
| `gobetween_user` | gobetween | gobetween user |
| `gobetween_target_servers` | ["localhost"] | |
| `gobetween_log_level` | info | log level |
| `gobetween_profiler` | false | expose profiler endpoint |
| `gobetween_api` | false | expose api endpoint |
| `gobetween_metrics` | true | expose prometheus metrics endpoint |
| `gobetween_metrics_port` | 9101 | metrics endpoint port |
| `gobetween_groups` | "" | servers to configure on gobetween.toml |

## Examples

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
        gobetween_groups:
          - {name: syslog, port: 514, protocol: udp, targets: "{{ gobetween_target_servers }}" }
          - {name: snmp, port: 162, protocol: udp, targets: "{{ gobetween_target_servers }}" }
	  environment: 
	    http_proxy: "{{ http_proxy }}"
	    https_proxy: "{{ https_proxy }}"
	    no_proxy: "{{ no_proxy }}

## License

This project is licensed under MIT License. See [LICENSE](/LICENSE) for more details.
