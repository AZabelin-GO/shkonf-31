data "yandex_compute_image" "images" {
  for_each = toset([for instance in local.compute_instances : instance.boot_disk.image_family])
  family   = each.key
}

resource "yandex_compute_instance" "instances" {
  for_each = { for instance in local.compute_instances : instance.name => instance }
  name     = each.key
  hostname = each.key

  metadata = {
    serial-port-enable = 1
    user-data = templatefile("./templates/cloud-init.yaml.tftpl", {
      admin_ssh_login      = sensitive(local.admin_ssh_login)
      admin_ssh_public_key = chomp(tls_private_key.this.public_key_openssh)
    })
  }

  platform_id = each.value.platform_id

  scheduling_policy {
    preemptible = true
  }

  resources {
    core_fraction = each.value.resources.core_fraction
    cores         = each.value.resources.cores
    memory        = each.value.resources.memory
  }

  boot_disk {
    initialize_params {
      name     = each.key
      image_id = data.yandex_compute_image.images["${each.value.boot_disk.image_family}"].id
      type     = each.value.boot_disk.type
      size     = each.value.boot_disk.size
    }
  }

  network_interface {
    nat       = true
    subnet_id = yandex_vpc_subnet.subnets["${each.value.network_interface.network_name}:${each.value.network_interface.subnet_zone}"].id
  }
}