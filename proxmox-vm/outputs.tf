
output "ip_address_server" {
  value = proxmox_vm_qemu.server[0].default_ipv4_address
}

output "mac_address_server" {
  value = proxmox_vm_qemu.server[0].network.0.macaddr
}


