locals {
  cts = {
    ansible-controller = { id = 301, ip = "192.168.20.31", mem = 512,  cores = 1, disk = 4 }
    jenkins-master     = { id = 302, ip = "192.168.20.32", mem = 1624, cores = 1, disk = 10 }
    jenkins-agent      = { id = 303, ip = "192.168.20.33", mem = 1024, cores = 1, disk = 8 }
  }
}


module "lxc" {
  source   = "./modules/lxc"
  for_each = local.cts

  name        = each.key
  vmid        = each.value.id
  ip          = each.value.ip
  memory      = each.value.mem
  gateway     = "192.168.20.1"
  node_name   = "pve1"
  template_id = 103   # your CT template's ID
  ssh_public_key = var.ssh_public_key
}

moved {
  from = proxmox_virtual_environment_container.node["jenkins-master"]
  to   = module.lxc["jenkins-master"].proxmox_virtual_environment_container.this
}

moved {
  from = proxmox_virtual_environment_container.node["jenkins-agent"]
  to   = module.lxc["jenkins-agent"].proxmox_virtual_environment_container.this
}

moved {
  from = proxmox_virtual_environment_container.node["ansible-controller"]
  to   = module.lxc["ansible-controller"].proxmox_virtual_environment_container.this
}
