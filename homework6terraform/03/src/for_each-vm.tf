variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
}

resource "yandex_compute_instance" "database" {
  for_each = {
    for vm in var.each_vm : vm.vm_name => vm
  }

  name        = each.key
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.default_b.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }

  scheduling_policy {
    preemptible = true
  }

  allow_stopping_for_update = true
}