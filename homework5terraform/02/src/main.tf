/*
resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}
*/

data "yandex_vpc_subnet" "existing" {
  name = "default-ru-central1-b" #существующая подсеть
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_full_name
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = data.yandex_vpc_subnet.existing.id
    nat       = var.vm_web_nat
  }

  metadata = merge(
    var.vm_common_metadata, # Новая map переменная с serial-port-enable
    {
      ssh-keys = "ubuntu:${var.vms_ssh_public_root_key}"
    }
  )

}

# Новая db ВМ (копируем и изменяем)
resource "yandex_compute_instance" "db" {
  name        = local.vm_db_full_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.existing.id
    nat       = var.vm_web_nat
  }

  metadata = merge(
    var.vm_common_metadata, # Новая map переменная с serial-port-enable
    {
      ssh-keys = "ubuntu:${var.vms_ssh_public_root_key}"
    }
  )
}