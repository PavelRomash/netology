# Создание двух одинаковых ВМ с использованием count
resource "yandex_compute_instance" "web" {
  count = 2

  name        = "web-${count.index + 1}" # web-1 и web-2
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id  # Ubuntu 22.04 LTS
      size     = 10
    }
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.default_b.id
    nat                = true                                   # Публичный IP
    security_group_ids = [yandex_vpc_security_group.example.id] # Назначение группы безопасности
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }

  scheduling_policy {
    preemptible = true # (прерываемая ВМ)
  }

  allow_stopping_for_update = true
}


output "vm_info" {
  value = [
    for vm in yandex_compute_instance.web : {
      name        = vm.name
      id          = vm.id
      internal_ip = vm.network_interface[0].ip_address
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn        = vm.fqdn
    }
  ]
}