Чек лист.
1. Установка terraform
![alt text](<Снимок экрана 2025-11-30 в 15.59.31.png>)

2. Гит репозиторий
![alt text](<Снимок экрана 2025-11-30 в 15.24.31.png>)

3. Установка docker
![alt text](<Снимок экрана 2025-11-27 в 18.00.35.png>)

# Задание 1

1. Зависимости скачаны

2. personal.auto.tfvars

3. "result": "GyL74evxK5BU7Rxf"

4. Исправил ![alt text](<Снимок экрана 2025-11-27 в 18.00.35-1.png>)

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

Вывод команды docker ps ![alt text](<Снимок экрана 2025-12-02 в 12.05.41.png>)

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
![alt text](<Снимок экрана 2025-12-02 в 14.46.21.png>)

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