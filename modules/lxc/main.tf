resource "proxmox_virtual_environment_container" "this" {
  node_name = var.node_name
  vm_id     = var.vmid
  unprivileged  = true
  started       = true

  clone {
    vm_id = var.template_id
  }

  initialization {
    hostname = var.name
    ip_config {
      ipv4 {
        address = "${var.ip}/24"
        gateway = var.gateway
      }
    }
    dns { servers = ["1.1.1.1"] }
    user_account {
      keys = [var.ssh_public_key]   # logs in as root with your key
    }
  }

  features {
    nesting = true
  }

  cpu    { cores = var.cores }
  memory { dedicated = var.memory }


  network_interface {
    name    = "eth0"
    bridge  = "vmbr0"
    vlan_id = var.vlan_id
  }
}
