locals {
  cts = {
    ansible-controller = { id = 301, ip = "192.168.20.31", mem = 512,  cores = 1, disk = 4 }
    jenkins-master     = { id = 302, ip = "192.168.20.32", mem = 1024, cores = 1, disk = 10 }
    jenkins-agent      = { id = 303, ip = "192.168.20.33", mem = 1024, cores = 1, disk = 8 }
  }
}

resource "proxmox_virtual_environment_container" "node" {
  for_each      = local.cts
  node_name     = "pve1"
  vm_id         = each.value.id
  unprivileged  = true
  started       = true


  clone {
    vm_id = 103   # your CT template's ID
  }


  features {
    nesting = true   # needed if the agent will run Docker
  }

  cpu    { cores = each.value.cores }
  memory { dedicated = each.value.mem }


  network_interface {
    name    = "eth0"
    bridge  = "vmbr0"
    vlan_id = 20
  }

  initialization {
    hostname = each.key
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = "192.168.20.1"
      }
    }
    dns { servers = ["1.1.1.1"] }
    user_account {
      keys = [var.ssh_public_key]   # logs in as root with your key
    }
  }
}
