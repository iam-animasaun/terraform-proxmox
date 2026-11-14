terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.66"
    }
  }
}

provider "proxmox" {
  endpoint  = "https://192.168.164.216:8006/"
  api_token = var.pve_api_token   # format: terraform@pve!tf=<secret>
  insecure  = true                # self-signed cert
  ssh {
    agent    = true
    username = "root"
  }
}
