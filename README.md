# ansible-apps_gobetween

[![Galaxy Role](https://img.shields.io/badge/galaxy-apps_gobetween-purple?style=flat)](https://galaxy.ansible.com/lotusnoir/apps_gobetween)
[![Version](https://img.shields.io/github/release/lotusnoir/ansible-apps_gobetween.svg)](https://github.com/lotusnoir/ansible-apps_gobetween/releases/latest)
[![GitHub repo size](https://img.shields.io/github/repo-size/lotusnoir/ansible-apps_gobetween?color=orange&style=flat)](https://galaxy.ansible.com/lotusnoir/apps_gobetween)
[![downloads](https://img.shields.io/ansible/role/d/56090)](https://galaxy.ansible.com/lotusnoir/apps_gobetween)
[![Ansible Quality Score](https://img.shields.io/ansible/quality/56090)](https://galaxy.ansible.com/lotusnoir/apps_gobetween)
[![License](https://img.shields.io/badge/license-Apache--2.0-brightgreen?style=flat)](https://opensource.org/licenses/Apache-2.0)

## Description

Deploy [gobetween](https://github.com/yyyar/gobetween/releases) load balancer system using ansible
## Requirements

none

## Role variables

See [variables](/defaults/main.yml) for more details.

## Examples

        ---
        - hosts: apps_gobetween
          become: true
          become_method: sudo
          gather_facts: true
          roles:
            - role: ansible-apps_gobetween

## Grafana Dashboard

You can find a grafana dashboard [here](https://grafana.com/grafana/dashboards/13571)

## License

This project is licensed under Apache License. See [LICENSE](/LICENSE) for more details.

## Author Information

- [Philippe LEAL](https://github.com/lotusnoir)
