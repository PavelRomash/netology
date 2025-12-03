# Задание 1

1. Изучил

2. Создал сервисный аккаунт и ключ. service_account_key_file.

3. Записал открытую(public) часть ssh ключа в переменную vms_ssh_public_root_key.

4.
Оошибка 1: Неправильное имя переменной SSH ключа
'''bash
### Было:
ssh-keys = "ubuntu:${var.vms_ssh_root_key}"

### Правильно:
ssh-keys = "ubuntu:${var.vms_ssh_public_root_key}"
'''

Ошибка 2: Неправильный platform_id
'''bash
### Было:
platform_id = "standart-v4"  #  опечатка "standart" v-4 излишне

### Правильно:
platform_id = "standard-v1" дешево
'''

Ошибка 3: При инициализации
### Было:
D:\Netology\Задания\homework5terraform\ter-homeworks\02\src\.terrafotm.rc

### Правильно:
"C:\Users\Legion\AppData\Roaming\terrafotm.rc"

5. Подключился. 

6.  preemptible = true (прерываемая виртуальная машина)
    - Экономия средств;
    - тестирование отказоутойчивости;
    - обучение мониторингу и автоматическому восстановлению;
    - разработка и тестирование CI/CD пайплайнов.

    core_fraction=5 (минимальная доля vCPU)
    - Экономия ресурсов;
    - обучение оптимизации ресурсов;
    - разработка и отладка приложений.


скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес


скриншот консоли, curl должен отобразить тот же внешний ip-адрес

# Задание 2

1. Заменил все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance

2. Объявил нужные переменные в файле variables.tf

3. Проверьте terraform plan. Изменений быть не должно.
Скриншот

# Задание 3

1. Создал в корне проекта файл 'vms_platform.tf' 

2. Выполнил блок ресурса и создал с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores  = 2, memory = 2, core_fraction = 20. Объявил её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"

3. Применил изменения. 

# Задание 4

1. Объявил в файле outputs.tf один output

'''bash
output "all_vms_info" {
  description = "Information about all virtual machines"
  value = {
    web = {
      instance_name = yandex_compute_instance.platform.name
      external_ip   = yandex_compute_instance.platform.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.platform.fqdn
    }
    db = {
      instance_name = yandex_compute_instance.db.name
      external_ip   = yandex_compute_instance.db.network_interface[0].nat_ip_address
      fqdn          = yandex_compute_instance.db.fqdn
    }
  }
}
'''

2. Изменения применил.

Вывод команды:
'''bash
PS D:\Netology\Задания\homework5terraform\ter-homeworks\02\src> C:\Users\Legion\yandex-terraform\terraform.exe output      
all_vms_info = {
  "db" = {
    "external_ip" = "158.160.87.170"
    "fqdn" = "epdb49eh375v08l117h3.auto.internal"
    "instance_name" = "netology-develop-platform-db"
  }
  "db" = {
    "external_ip" = "158.160.87.170"
    "fqdn" = "epdb49eh375v08l117h3.auto.internal"
    "instance_name" = "netology-develop-platform-db"
  }
  }
  "web" = {
    "external_ip" = "158.160.76.25"
    "fqdn" = "epdnvm7dnpgh1qg526u5.auto.internal"
    "external_ip" = "158.160.76.25"
    "fqdn" = "epdnvm7dnpgh1qg526u5.auto.internal"
    "fqdn" = "epdnvm7dnpgh1qg526u5.auto.internal"
    "instance_name" = "netology-develop-platform-web"
  }
}
'''

# Здание 5

1. В файле locals.tf описал в одном local-блоке имя каждой ВМ

2. Заменил переменные внутри ресурса ВМ на созданные local-переменные.

3. Применил изменения

'''bash
Outputs:

all_vms_info = {
  "db" = {
    "external_ip" = "158.160.87.170"
    "fqdn" = "epdb49eh375v08l117h3.auto.internal"
    "instance_name" = "vm-netology-develop-platform-db-2cpu-2gb-ru-central1-b"
    "local_name" = "vm-netology-develop-platform-db-2cpu-2gb-ru-central1-b"
  }
  "web" = {
    "external_ip" = "158.160.76.25"
    "fqdn" = "epdnvm7dnpgh1qg526u5.auto.internal"
    "instance_name" = "vm-netology-develop-platform-web-2cpu-1gb"
    "local_name" = "vm-netology-develop-platform-web-2cpu-1gb"
  }
'''

# Задание 6

1. ### Map переменная для ресурсов ВМ

'''bash
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
  description = "Resources configuration for virtual machines"
}
'''

2. ### Map переменная для metadata (общая для всех ВМ)
variable "vm_common_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    # ssh-keys будет добавляться отдельно в main.tf
  }
  description = "Common metadata for all virtual machines"
}

3. Закоментировал все, более не используемые переменные проекта.

4. Проверил terraform plan. Изменений нет. 
скриншот
