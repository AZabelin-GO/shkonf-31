locals {
  networks = [
    {
      name = "shkonf-31"
    }
  ]

  subnets = [
    {
      network_name = "shkonf-31"
      zone         = "ru-central1-a"
      v4_cidr_blocks = [
        "10.10.1.0/24"
      ]
    }
  ]

  security_groups = [
    {
      name         = "shkonf-31"
      network_name = "shkonf-31"
    }
  ]

  security_group_rules = [
    {
      name                = "ssh"
      security_group_name = "shkonf-31"
      direction           = "ingress"
      protocol            = "TCP"
      port                = 22
      v4_cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      name                = "http"
      security_group_name = "shkonf-31"
      direction           = "ingress"
      protocol            = "TCP"
      port                = 80
      v4_cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      name                = "https"
      security_group_name = "shkonf-31"
      direction           = "ingress"
      protocol            = "TCP"
      port                = 443
      v4_cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      name                = "clickhouse-plain"
      security_group_name = "shkonf-31"
      direction           = "ingress"
      protocol            = "TCP"
      port                = 9000
      v4_cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      name                = "clickhouse-secured"
      security_group_name = "shkonf-31"
      direction           = "ingress"
      protocol            = "TCP"
      port                = 9440
      v4_cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      name                = "clickhouse-http"
      security_group_name = "shkonf-31"
      direction           = "ingress"
      protocol            = "TCP"
      port                = 8123
      v4_cidr_blocks = [
        "0.0.0.0/0"
      ]
    },
    {
      name                = "clickhouse-https"
      security_group_name = "shkonf-31"
      direction           = "ingress"
      protocol            = "TCP"
      port                = 8443
      v4_cidr_blocks = [
        "0.0.0.0/0"
      ]
    }
  ]

  compute_instances = [
    {
      name        = "clickhouse-1"
      platform_id = "standard-v3"

      resources = {
        cores         = 2
        memory        = 1
        core_fraction = 20
      }

      boot_disk = {
        image_family = "ubuntu-2404-lts"
        type         = "network-hdd"
        size         = 10
      }

      network_interface = {
        network_name = "shkonf-31"
        subnet_zone  = "ru-central1-a"
      }
    },
    {
      name        = "vector-1"
      platform_id = "standard-v3"

      scheduling_policy = {
        preemptible = true
      }

      resources = {
        cores         = 2
        memory        = 1
        core_fraction = 20
      }

      boot_disk = {
        image_family = "ubuntu-2404-lts"
        type         = "network-hdd"
        size         = 10
      }

      network_interface = {
        network_name = "shkonf-31"
        subnet_zone  = "ru-central1-a"
      }
    },
    {
      name        = "lighthouse-1"
      platform_id = "standard-v3"

      scheduling_policy = {
        preemptible = true
      }

      resources = {
        cores         = 2
        memory        = 1
        core_fraction = 20
      }

      boot_disk = {
        image_family = "ubuntu-2404-lts"
        type         = "network-hdd"
        size         = 10
      }

      network_interface = {
        network_name = "shkonf-31"
        subnet_zone  = "ru-central1-a"
      }
    }
  ]

  admin_ssh_login = "ansible"
}