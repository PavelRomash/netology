data "template_file" "cloud_init" {
  template = file("${path.module}/../scripts/cloud-init.yaml")

  vars = {
    ssh_public_key     = var.ssh_public_key
    lockbox_secret_id = yandex_lockbox_secret.mysql_password.id
  }
}


data "yandex_iam_service_account" "existing" {
  folder_id = var.folder_id      
  name      = "terraformfinal"
}

data "yandex_compute_image" "ubuntu" {
  family = var.os_family
}

resource "yandex_compute_instance" "vm-1" {
  name        = "web-server"
  platform_id = "standard-v3"
  zone        = var.zone

  service_account_id = data.yandex_iam_service_account.existing.id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-a.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.sg-web.id]
  }

  metadata = {
    user-data = data.template_file.cloud_init.rendered
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.network_interface.0.nat_ip_address
  }
}
