variable "yc_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "yc_region_id" {
  type    = string
  default = "ru-central1"
}

variable "yc_cloud_id" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

variable "yc_subnet_id" {
  type = string
}

variable "app_disk_image" {
  type = string
}

variable "db_disk_image" {
  type = string
}

variable "yc_bucket_name" {
  type = string
}

variable "service_account_key_file" {
  type = string
}

variable "ssh_public_key" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key" {
  type    = string
  default = "~/.ssh/id_rsa"
}

variable "instance_count" {
  type    = number
  default = 1
}
