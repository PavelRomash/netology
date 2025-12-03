locals {
  # local переменные
  vm_web_full_name = "vm-${var.vm_web_name}-${var.vms_resources["web"].cores}cpu-${var.vms_resources["web"].memory}gb"
  vm_db_full_name  = "vm-${var.vm_db_name}-${var.vms_resources["db"].cores}cpu-${var.vms_resources["db"].memory}gb-${var.vm_db_zone}"
}