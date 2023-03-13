# Deploying VM's via Terraform
Thanks to the VM Template deployed via Packer as I have explained [in the Packer repository](https://github.com/AntonioBriPerez/packer-proxmox-templates) it is quite simple to deploy VM's via terraform. 
It is very importante to notice that the Terraform Proxmox plugin crash when an HDD disk is attached to VM to we have to dettach it manually from the proxmox gui before doing anything in proxmox. 

This repository must containa  file called credentials.auto.tfvars with the following content: 
```hcl
proxmox_api_url          = "https://0.0.0.0:8006/api2/json" # Your Proxmox IP Address
proxmox_api_token_id     = "user@pam!terraform"                   # API Token ID
proxmox_api_token_secret = "token"
```
Chaning this values for whatever it takes in your case. 

## Terraform VM's files
All 3 current machines: samba, plex and wireguard has the same exact configuration. The code should be refactored but it will be done in the future. 

```hcl
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
  scsihw      = "virtio-scsi-pci"

  # bootdisk = "scsi0"
...
```
We first define some parameters that makes easy to manage the VM. For example, we set static vmid (it makes easier to manage the Ansible inventory) and we define the HW specification of the machine. Now we define the network configuration: 
```hcl
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
    public-key
  EOF
```
We set an static IP and an static macaddr to make the port forwarding in our router easier. At the end, we set the user of the machine and the public key so we can SSH into de machine. Finally, we define the outputs: 

```hcl
output "ip_address_plex_server" {
  value = proxmox_vm_qemu.plex-server[0].default_ipv4_address
}

output "mac_address_plex_server" {
  value = proxmox_vm_qemu.plex-server[0].network.0.macaddr
}

```
This makes easier to update our inventory in Ansible. However, it is interesting to analyze the option of having a dynamic inventory. 