variable "cloud_id" {
  description = "Yandex Cloud Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  default     = "b1gffvvt5vf4oe546s5q"
}

variable "zone" {
  description = "Yandex Cloud Zone"
  type        = string
  default     = "ru-central1-a"
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "os_family" {
  default = "ubuntu-2204-lts"
}

variable "vm_username" {
  description = "Username for VM"
  type        = string
  default     = "ubuntu"
}

variable "service_account_key_file" {
  description = "Path to service account key file"
  type        = string
  default     = "./key.json" 
}

