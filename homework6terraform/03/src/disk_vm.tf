# Файл disk_vm.tf

# 1. Создаем 3 одинаковых виртуальных диска размером 1 Гб с помощью count
resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name = "storage-disk-${count.index}"
  type = "network-hdd"
  zone = var.default_zone
  size = 1 # 1 ГБ
}

# 2. Создаем одиночную ВМ "storage" (без count/for_each)
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.default_b.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  # 3. Используем dynamic secondary_disk с for_each для подключения дисков
  dynamic "secondary_disk" {
    for_each = {
      for idx, disk in yandex_compute_disk.storage_disks : idx => disk.id
    }
    content {
      disk_id = secondary_disk.value
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }

  scheduling_policy {
    preemptible = true
  }

  allow_stopping_for_update = true
}