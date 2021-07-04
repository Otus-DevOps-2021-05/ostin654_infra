provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
}

module "app" {
  name = "reddit-app"
  source          = "../modules/app"
  ssh_public_key = var.ssh_public_key
  disk_image  = var.app_disk_image
  subnet_id       = var.yc_subnet_id
  cores = 4
  memory = 4
  core_fraction = 5
}

module "db" {
  name = "reddit-db"
  source          = "../modules/db"
  ssh_public_key = var.ssh_public_key
  disk_image   = var.db_disk_image
  subnet_id       = var.yc_subnet_id
  cores = 2
  memory = 2
  core_fraction = 20
}
