# Ресурс для кластера Managed MySQL
resource "yandex_mdb_mysql_cluster" "mysql-cluster" {
  name        = "netology-mysql"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.network.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  host {
    zone      = var.zone
    subnet_id = yandex_vpc_subnet.subnet-a.id
    assign_public_ip = true
  }

  security_group_ids = [yandex_vpc_security_group.sg-web.id]
}

# Отдельный ресурс для базы данных
resource "yandex_mdb_mysql_database" "appdb" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
  name       = "appdb"
}

# Отдельный ресурс для пользователя
resource "yandex_mdb_mysql_user" "appuser" {
  cluster_id = yandex_mdb_mysql_cluster.mysql-cluster.id
  name       = "appuser"
  password   = yandex_lockbox_secret_version.mysql_password_version.entries[0].text_value

  permission {
    database_name = yandex_mdb_mysql_database.appdb.name
    roles         = ["ALL"]
  }
}
