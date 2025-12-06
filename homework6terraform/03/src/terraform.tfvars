
default_zone = "ru-central1-b"
existing_network_name = "default"
existing_subnet_name  = "default-ru-central1-b"
vms_ssh_public_root_key = "C:/Users/Legion/.ssh/id_rsa.pub"
vm_image_id = "fd87vvgamed91jv09b4h"

each_vm = [
  {
    vm_name     = "main"
    cpu         = 4
    ram         = 8
    disk_volume = 50
  },
  {
    vm_name     = "replica"
    cpu         = 2
    ram         = 4
    disk_volume = 30
  }
]