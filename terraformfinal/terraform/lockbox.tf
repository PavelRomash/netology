resource "yandex_lockbox_secret" "mysql_password" {
  name = "mysql-password"
}

resource "yandex_lockbox_secret_version" "mysql_password_version" {
  secret_id = yandex_lockbox_secret.mysql_password.id

  entries {
    key        = "mysql_password"
    text_value = ""
  }
}
