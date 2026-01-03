resource "yandex_resourcemanager_folder_iam_member" "lockbox_access" {
  folder_id = var.folder_id
  role      = "admin"
  member    = "serviceAccount:${data.yandex_iam_service_account.existing.id}"
}