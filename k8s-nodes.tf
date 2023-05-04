
module "k8s-m" {
  source = "./proxmox-vm"

  vm-name  = "K8s-m"
  template = "RHEL9.1"
  cores    = 1
  vm-id    = "200"
  onboot   = true
  memory   = 2048
  macaddr  = "FE:1C:0D:9D:26:70"
  ipaddr   = "192.168.18.45/24"

}


module "k8s-n1" {
  source = "./proxmox-vm"

  vm-name  = "K8s-n1"
  template = "RHEL9.1"
  cores    = 1
  vm-id    = "201"
  onboot   = true
  memory   = 2048
  macaddr  = "FE:1C:0D:9D:26:71"
  ipaddr   = "192.168.18.46/24"

}


module "k8s-n2" {
  source = "./proxmox-vm"

  vm-name  = "K8s-n2"
  template = "RHEL9.1"
  cores    = 1
  vm-id    = "202"
  onboot   = true
  memory   = 2048
  macaddr  = "FE:1C:0D:9D:26:72"
  ipaddr   = "192.168.18.47/24"

}



