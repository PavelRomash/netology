output "vm_external_ip" {
  value = yandex_compute_instance.vm-1.network_interface[0].nat_ip_address
}

output "mysql_host_fqdn" {
  value = yandex_mdb_mysql_cluster.mysql-cluster.host[0].fqdn
}

output "registry_id" {
  value = yandex_container_registry.registry.id
}

output "registry_url" {
  value = "cr.yandex/${yandex_container_registry.registry.id}"
}
