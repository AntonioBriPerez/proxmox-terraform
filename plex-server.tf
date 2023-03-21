resource "proxmox_vm_qemu" "plex-server" {
  count       = 1
  name        = "plex-server"
  target_node = "torre-linux"
  clone       = "ubuntu-server-focal-test-1"
  agent       = 1
  vmid        = "101"
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 1
  cpu         = "host"
  memory      = 8192
  onboot      = true

  scsihw = "virtio-scsi-pci"
  # bootdisk = "scsi0"
  # disk {
  #   slot = 0
  #   # set disk size here. leave it small for testing because expanding the disk takes time.
  #   size     = "32G"
  #   type     = "scsi"
  #   storage  = "local"
  #   iothread = 0
  # }

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = "a2:b4:17:8e:39:a4"

  }
  lifecycle {
    ignore_changes = [
      network,
      disk
    ]
  }

  ipconfig0 = "ip=192.168.18.38/24,gw=192.168.18.1"
  ciuser    = "anton"
  sshkeys   = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUROBj7W+Sr0PswetL6uPc6l/BVcJnprAktesDetJK16TxPp0jqoxKsKAJT+6jkcF5krcvB9xGkzsYpBEB0ZhBM2hrXfLHk8GPQwLX/5xMB7k77maaMr1eAQj+bxCkvFCxynx7PecAm0x0gt2mm0hoywpNLCXoSzaqc9SGR0WSdXOz/5QVZmWQhRBoENop+x9XSYzlV/BTlEwMbhxbNE7sLD0lUWKci8rkg6Nstr6q+pp0UXxjn0j2H+5o8EZPVb3KeyuAbQOAZ4YZhOcpdC7U+ysV6l/wCI9IwAHbKwRUt62h+AyzlLfH/phlzSw1wWxPRfTa6xP+NAYIyT1G7GBd9e5qblRDUHwJQAYV7Mr997Pm3+5f4+o2N5BwwGQGAE72rkTyn75ALgBit4L6UQlkD/tNxM4YDQQ4bJ8cEURdOLumyUXelDnisC4qmHMMzUEjqvwMbqTJ6616oY5O9oO/amwOYK08O5KlO/ovMQpG07jg0gJgv+u4gV82jcUTAe8= anton@portatil-antonio
  EOF
}


output "ip_address_plex_server" {
  value = proxmox_vm_qemu.plex-server[0].default_ipv4_address
}

output "mac_address_plex_server" {
  value = proxmox_vm_qemu.plex-server[0].network.0.macaddr
}
