variable "name"        { type = string }
variable "vmid"        { type = number }
variable "ip"          { type = string }

variable "gateway" {
  type = string
}

variable "node_name" {
  type = string
}

variable "template_id" {
  type = number 
}

variable "cores" {
  type    = number
  default = 1
}
variable "memory" {
  type    = number
  default = 1024
}
variable "disk_gb" {
  type    = number
  default = 8
}
variable "vlan_id" {
  type    = number
  default = 20
}
variable "ssh_public_key" {
  type = string
}
