terraform {
  required_version = "~> 1.15.0"

  required_providers {
    yandex = {
      source  = "registry.terraform.io/yandex-cloud/yandex"
      version = "~> 0.213.0"
    }

    tls = {
      source  = "registry.terraform.io/hashicorp/tls"
      version = "~>4.3.0"
    }

    random = {
      source  = "registry.terraform.io/hashicorp/random"
      version = "~> 3.9.0"
    }
  }
}