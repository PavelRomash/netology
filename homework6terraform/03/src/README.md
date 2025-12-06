# Задание 1

1. Изучил проект

2. Инициализировал проект, выполнил код

Скриншот входящих правил «Группы безопасности»

<img width="1736" height="799" alt="вход правил без" src="https://github.com/user-attachments/assets/91f04a08-2c31-4207-ac22-d82597220f7f" />


# Задание 2

1. Создал файл count-vm.tf, назначил группу безопасности из 1го задания

```bash
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
      image_id = var.vm_image_id  # Ubuntu 22.04 LTS
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
```

2. Создал файл for_each-vm.tf

```bash
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
      image_id = var.vm_image_id
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
```

Инициализировал проект, выполнил код
Скриншот созданных вм
<img width="1879" height="621" alt="созданые вм" src="https://github.com/user-attachments/assets/3a2ed80c-3f7a-4c24-a984-48adc757a932" />


# Задание 3

1. Создал 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле disk_vm.tf

```bash
resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name     = "storage-disk-${count.index}"
  type     = "network-hdd"
  zone     = var.default_zone
  size     = 1  # 1 ГБ
}
```

2. Создал в том же файле одиночную(использовать count или for_each запрещено из-за задания №4) ВМ c именем "storage" . Использовал блок dynamic secondary_disk{..} и мета-аргумент for_each для подключения созданных мной дополнительных дисков.

Скриншоты созданнх дисков и вм

<img width="1875" height="924" alt="вм storage" src="https://github.com/user-attachments/assets/09dabd10-e00c-47d2-99c9-25ed0ec4e54b" />
<img width="1546" height="548" alt="3диска storage" src="https://github.com/user-attachments/assets/f4f03b69-2046-4b24-aa90-3d7dfc7f0a2b" />


# Задание 4

1. Создан файл ansible.tf

2. Инвентарь содержит 3 группы и является динамическим

3. Добавил в инвентарь переменную fqdn

Выполнил код, скриншот 
<img width="1437" height="612" alt="итог" src="https://github.com/user-attachments/assets/9129b8a2-5ec1-497e-a189-b5505c816b67" />
