Чек лист.
1. Установка terraform
<img width="917" height="247" alt="Снимок экрана 2025-12-02 в 15 03 14" src="https://github.com/user-attachments/assets/4b8443d7-6da1-415f-8e3c-24fb97feb513" />

2. Гит репозиторий
<img width="1434" height="964" alt="Снимок экрана 2025-11-30 в 15 24 31" src="https://github.com/user-attachments/assets/89630c79-c926-4ab0-b452-020ec25332ea" />

3. Установка docker
<img width="912" height="209" alt="Снимок экрана 2025-12-02 в 15 04 44" src="https://github.com/user-attachments/assets/3379cd72-71f9-4610-b759-379b9b9d9d3f" />

# Задание 1

1. Зависимости скачаны

2. personal.auto.tfvars

3. "result": "GyL74evxK5BU7Rxf"

4. Исправил 
<img width="1313" height="829" alt="Снимок экрана 2025-11-30 в 16 52 25" src="https://github.com/user-attachments/assets/b75ffa80-bf8e-4623-8dfd-c201698eb6f8" />


5. Исправленный фрагмент кода:
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}

Вывод команды docker ps 
<img width="1256" height="829" alt="Снимок экрана 2025-12-02 в 12 05 41" src="https://github.com/user-attachments/assets/38e88abc-db39-4929-97d5-0138902052d6" />

6. Изменение имени контейнера

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "hello_world"  # ← Имя контейнера изменено на hello_world

  ports {
    internal = 80
    external = 9090
  }
}

Опасность ключа -auto-approve:

Ключ -auto-approve автоматически подтверждает выполнение плана без интерактивного запроса подтверждения (без ввода yes).

Чем опасен:

Неконтролируемые изменения: Изменения в инфраструктуре применяются сразу, без возможности предварительного анализа плана.
Риск потери данных: Может случайно удалить или изменить критически важные ресурсы.
Отсутствие проверки: Не позволяет коллегам провести code review или double-check перед применением.
Потенциальные ошибки: Человеческий фактор — можно забыть добавить важный параметр или сделать опечатку.

Когда полезен:

CI/CD пайплайны: В автоматизированных процессах, где нет интерактивного ввода.
Скрипты: При автоматическом развертывании инфраструктуры.
Тестовые окружения: Где изменения не критичны и можно быстро откатить.
Ночные деплои: Когда применение происходит в нерабочее время.

Вывод команды docker ps
<img width="1254" height="825" alt="Снимок экрана 2025-12-02 в 14 46 21" src="https://github.com/user-attachments/assets/f8d7b5ac-ef9c-4964-ada9-2dd57bacb1ef" />

7. {
  "version": 4,
  "terraform_version": "1.12.0",
  "serial": 3,
  "lineage": "0aa915c2-beb4-890a-fdfd-64983bb34279",
  "outputs": {},
  "resources": [],
  "check_results": null
}

8. keep_locally = true   # ← Этот параметр предотвращает удаление образа (наш код)

keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.

Это означает, что при установке keep_locally = true образ остаётся в локальном хранилище Docker даже после выполнения команды terraform destroy. Если бы параметр был установлен в false (или не указан, так как значение по умолчанию — false), то образ был бы удалён при уничтожении ресурса.
