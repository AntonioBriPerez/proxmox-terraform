resource "proxmox_vm_qemu" "example_vm" {
  name        = "example-vm"
  target_node = "torre-linux"
  memory      = "1024"
  cores       = "1"
  sockets     = "1"
  network {
    model  = "virtio"
    bridge = "vmbr0"
  }
  disk {
    size    = "10G"
    type    = "virtio"
    storage = "local-lvm"
  }
}
