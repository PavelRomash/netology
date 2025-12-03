# Переменные для web ВМ (префикс vm_web_)

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of the web virtual machine"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for the web VM"
}

/*
variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for the web VM"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "Amount of memory in GB for the web VM"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 5
  description = "CPU core fraction percentage for the web VM"
}
*/

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for the web VM"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Whether the web VM is preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Enable NAT for the web VM"
}

/*
variable "vm_web_serial_port_enable" {
  type        = number
  default     = 1
  description = "Enable serial port for the web VM"
}
*/

# Переменные для db ВМ (префикс vm_db_)
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name of the db virtual machine"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Platform ID for the db VM"
}

/*
variable "vm_db_cores" {
  type        = number
  default     = 2
  description = "Number of CPU cores for the db VM"
}

variable "vm_db_memory" {
  type        = number
  default     = 2
  description = "Amount of memory in GB for the db VM"
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
  description = "CPU core fraction percentage for the db VM"
}
*/

variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for the db VM"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone for the db VM"
}


# Map переменная для ресурсов ВМ
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

# Map переменная для metadata (общая для всех ВМ)
variable "vm_common_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    # ssh-keys будет добавляться отдельно в main.tf
  }
  description = "Common metadata for all virtual machines"
}