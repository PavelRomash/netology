
data "yandex_vpc_network" "default" {
  name = var.existing_network_name
}

data "yandex_vpc_subnet" "default_b" {
  name = var.existing_subnet_name
}

# Выводим информацию для проверки
locals {
  network_info = {
    id   = data.yandex_vpc_network.default.id
    name = data.yandex_vpc_network.default.name
  }

  subnet_info = {
    id             = data.yandex_vpc_subnet.default_b.id
    name           = data.yandex_vpc_subnet.default_b.name
    zone           = data.yandex_vpc_subnet.default_b.zone
    v4_cidr_blocks = data.yandex_vpc_subnet.default_b.v4_cidr_blocks
  }
}

# Локальная переменная для ID сети (используется в security.tf)
locals {
  selected_network_id = data.yandex_vpc_network.default.id
}