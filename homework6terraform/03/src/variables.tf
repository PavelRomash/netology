###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "existing_network_name" {
  type        = string
  default     = "default"
  description = "Имя существующей сети VPC"
}

variable "existing_subnet_name" {
  type        = string
  default     = "default-ru-central1-b"
  description = "Имя существующей подсети"
}

# SSH ключ для ВМ
variable "vms_ssh_public_root_key" {
  type        = string
  default     = "C:\\Users\\Legion\\.ssh\\id_rsa.pub" # Путь к публичному SSH ключу
  description = "Path to SSH public key"
}

# Идентификатор образа ОС
variable "vm_image_id" {
  type        = string
  default     = "fd8kb72eo1r5fs97a1du" # Ubuntu 22.04 LTS
  description = "VM image ID"
}

