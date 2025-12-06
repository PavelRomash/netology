# ansible.tf

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = yandex_compute_instance.database
    storage    = yandex_compute_instance.storage
  })
  filename = "${path.module}/hosts.ini"
}