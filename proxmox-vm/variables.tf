variable "vm-name" {
  type        = string
  description = "Name of the VM"
}

variable "template" {
  type        = string
  description = "Name of the template (must exist in Proxmox templates)"
}

variable "cores" {
  type        = number
  description = "Number of cores of the VM"
}

variable "vm-id" {
  type        = string
  description = "ID of the VM"
}

variable "memory" {
  type        = number
  description = "RAM memory size in MB"
}

variable "onboot" {
  type        = bool
  description = "Whether the VM starts up on boot"
}

variable "macaddr" {
  type        = string
  description = "MAC Address"
}

variable "ipaddr" {
  type        = string
  description = "IP address"
}
