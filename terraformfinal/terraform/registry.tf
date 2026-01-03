resource "yandex_container_registry" "registry" {
  name = "netology-registry"
}

resource "yandex_container_repository" "app_repo" {
  name = "${yandex_container_registry.registry.id}/netology-app"
}

