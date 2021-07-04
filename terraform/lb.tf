resource "yandex_lb_target_group" "lb_group" {
  name      = "reddit-app-group"
  region_id = var.yc_region_id

  dynamic "target" {
    for_each = yandex_compute_instance.app
    content {
      address   = target.value.network_interface.0.ip_address
      subnet_id = var.yc_subnet_id
    }
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  name = "reddit-app-lb"

  listener {
    name        = "reddit-app-listener"
    port        = 80
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lb_group.id

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}
