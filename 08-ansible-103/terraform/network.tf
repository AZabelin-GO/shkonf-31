resource "yandex_vpc_network" "networks" {
  for_each = { for network in local.networks : network.name => network }
  name     = each.key
}

resource "yandex_vpc_subnet" "subnets" {
  for_each       = { for subnet in local.subnets : "${subnet.network_name}:${subnet.zone}" => subnet }
  name           = "${each.value.network_name}-${each.value.zone}"
  network_id     = yandex_vpc_network.networks["${each.value.network_name}"].id
  v4_cidr_blocks = each.value.v4_cidr_blocks
  zone           = each.value.zone
}

resource "yandex_vpc_security_group" "security_groups" {
  for_each   = { for security_group in local.security_groups : security_group.name => security_group }
  name       = each.key
  network_id = yandex_vpc_network.networks["${each.value.network_name}"].id
}

resource "yandex_vpc_security_group_rule" "rules" {
  for_each               = { for rule in local.security_group_rules : "${rule.security_group_name}:${rule.name}" => rule }
  security_group_binding = yandex_vpc_security_group.security_groups["${each.value.security_group_name}"].id
  direction              = each.value.direction
  protocol               = each.value.protocol
  port                   = each.value.port
  v4_cidr_blocks         = each.value.v4_cidr_blocks
}
