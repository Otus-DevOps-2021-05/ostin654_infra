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

variable "yc_image_id" {
  type = string
}

variable "yc_subnet_id" {
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
