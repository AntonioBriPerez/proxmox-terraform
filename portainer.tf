resource "proxmox_vm_qemu" "portainer-server" {
  count = 1                  # just want 1 for now, set to 0 and apply to destroy VM
  name  = "portainer-server" #count.index starts at 0, so + 1 means this VM will be named test-vm-1 in proxmox
  # this now reaches out to the vars file. I could've also used this var above in the pm_api_url setting but wanted to spell it out up there. target_node is different than api_url. target_node is which node hosts the template and thus also which node will host the new VM. it can be different than the host you use to communicate with the API. the variable contains the contents "prox-1u"
  target_node = "torre-linux"
  # another variable with contents "ubuntu-2004-cloudinit-template"
  clone = "debian-template"
  # basic VM settings here. agent refers to guest agent
  agent   = 1
  os_type = "cloud-init"
  cores   = 2
  sockets = 1
  cpu     = "host"
  memory  = 2048
  scsihw  = "virtio-scsi-pci"

  bootdisk = "scsi0"
  disk {
    slot = 0
    # set disk size here. leave it small for testing because expanding the disk takes time.
    size     = "32G"
    type     = "scsi"
    storage  = "local"
    iothread = 0
  }

  # if you want two NICs, just copy this whole network section and duplicate it
  network {
    model  = "virtio"
    bridge = "vmbr0"

  }
  # not sure exactly what this is for. presumably something about MAC addresses and ignore network changes during the life of the VM
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
