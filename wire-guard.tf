resource "proxmox_vm_qemu" "wireguard-server" {
  count = 1                  # just want 1 for now, set to 0 and apply to destroy VM
  name  = "wireguard-server" #count.index starts at 0, so + 1 means this VM will be named test-vm-1 in proxmox
  # this now reaches out to the vars file. I could've also used this var above in the pm_api_url setting but wanted to spell it out up there. target_node is different than api_url. target_node is which node hosts the template and thus also which node will host the new VM. it can be different than the host you use to communicate with the API. the variable contains the contents "prox-1u"
  target_node = "torre-linux"
  # another variable with contents "ubuntu-2004-cloudinit-template"
  clone = "ubuntu-server-focal-test-1"
  # basic VM settings here. agent refers to guest agent
  agent   = 1
  os_type = "cloud-init"
  cores   = 1
  vmid    = "102"

  sockets = 1
  cpu     = "host"
  memory  = 1024
  scsihw  = "virtio-scsi-pci"
  onboot  = true
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
    macaddr = "22:EA:D5:7F:00:23"
  }
  # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=192.168.18.39/24,gw=192.168.18.1"
  ciuser    = "anton"
  sshkeys   = <<EOF
  ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDUROBj7W+Sr0PswetL6uPc6l/BVcJnprAktesDetJK16TxPp0jqoxKsKAJT+6jkcF5krcvB9xGkzsYpBEB0ZhBM2hrXfLHk8GPQwLX/5xMB7k77maaMr1eAQj+bxCkvFCxynx7PecAm0x0gt2mm0hoywpNLCXoSzaqc9SGR0WSdXOz/5QVZmWQhRBoENop+x9XSYzlV/BTlEwMbhxbNE7sLD0lUWKci8rkg6Nstr6q+pp0UXxjn0j2H+5o8EZPVb3KeyuAbQOAZ4YZhOcpdC7U+ysV6l/wCI9IwAHbKwRUt62h+AyzlLfH/phlzSw1wWxPRfTa6xP+NAYIyT1G7GBd9e5qblRDUHwJQAYV7Mr997Pm3+5f4+o2N5BwwGQGAE72rkTyn75ALgBit4L6UQlkD/tNxM4YDQQ4bJ8cEURdOLumyUXelDnisC4qmHMMzUEjqvwMbqTJ6616oY5O9oO/amwOYK08O5KlO/ovMQpG07jg0gJgv+u4gV82jcUTAe8= anton@portatil-antonio
  EOF
}


output "ip_address_wireguard_server" {
  value = proxmox_vm_qemu.wireguard-server[0].default_ipv4_address
}

output "mac_address_wireguard_server" {
  value = proxmox_vm_qemu.wireguard-server[0].network.0.macaddr
}
