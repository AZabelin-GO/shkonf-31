output "ansible_ssh_login" {
  value       = local.admin_ssh_login
  sensitive   = true
  description = "Admin SSH username"
}

output "ansible_ssh_private_key" {
  value       = tls_private_key.this.private_key_openssh
  sensitive   = true
  description = "Private key for Admin SSH user"
}

output "ansible_inventory" {
  value = yamlencode({
    all = {
      children = {
        for group_name, instances in {
          for name, instances in yandex_compute_instance.instances : split("-", name)[0] => instances...
        } :

        group_name => {
          hosts = {
            for host in instances: host.name => {
                ansible_host = host.network_interface[0].nat_ip_address
                internal_ip = host.network_interface[0].ip_address
            }
          }
        }
      }
    }
  })
}