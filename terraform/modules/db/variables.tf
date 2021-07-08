variable name {
  description = "Instance name"
  default = "reddit-db"
}

variable cores {
  description = "Core number for instance"
  type = number
  default = 2
}

variable memory {
  description = "Memory GB for instance"
  type = number
  default = 2
}

variable core_fraction {
  description = "Core fraction for instance"
  type = number
  default = 50
}

variable disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}

variable subnet_id {
  description = "Subnets for modules"
}

variable is_nat {
  description = "Use NAT?"
  type = bool
  default = false
}

variable ssh_public_key {
  description = "Path to the public key used for ssh access"
}
