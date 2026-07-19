# Lesson 04 - Ansible 104

## Precondition

1. Prepare environment in Yandex Cloud (see `Precondition` section in [Lesson 03 README.md](../08-ansible-103/README.md))
2. Download roles and collections using command `ansible-galaxy install -r requirements.yaml`

## Solution

* Role for Clickhouse: https://github.com/AZabelin-GO/shkonf-31-08-ansible-104-clickhouse.git (installs Clickhouse and python driver for it)
* Role for Lighthouse: https://github.com/AZabelin-GO/shkonf-31-08-ansible-104-lighthouse.git (installs Nginx and downloads Lighthouse from git)
* Role for Vector: https://github.com/AZabelin-GO/shkonf-31-08-ansible-104-vector.git (installs Vector and adds demo logs generator which are stored in Clickhouse)
* To run ansible playbook use command `ansible-playbook --private-key private_key playbook/site.yaml`
* To check logs in Clickhouse use Lighthouse with data-source URL `http://<clickhouse_ip>:8123/?user=<vector or admin username>`
