output "network_details" {
  value       = local.network_info
  description = "Информация об используемой сети"
}

output "subnet_details" {
  value       = local.subnet_info
  description = "Информация об используемой подсети"
}

output "security_group_created" {
  value       = yandex_vpc_security_group.example.name
  description = "Имя созданной группы безопасности"
}