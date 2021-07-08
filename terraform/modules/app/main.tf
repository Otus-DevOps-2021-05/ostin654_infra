resource "yandex_compute_instance" "app" {
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

  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.ssh_private_key)
  }

  provisioner "file" {
    content     = "DATABASE_URL=${var.db_host}:${var.db_port}\n"
    destination = "/home/ubuntu/db.env"
  }

  provisioner "file" {
    source      = "../modules/app/files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "../modules/app/files/deploy.sh"
  }
}
