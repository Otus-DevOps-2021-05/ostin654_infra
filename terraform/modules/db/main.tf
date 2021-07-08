resource "yandex_compute_instance" "db" {
  name = var.name

  resources {
    cores  = var.cores
    memory = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = var.is_nat
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key)}"
  }
}
