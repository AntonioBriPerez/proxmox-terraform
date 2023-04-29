
module "k8s-master" {
  source = "./proxmox-vm"

  vm-name  = "zabbix-server"
  template = "ubuntu-server-focal-30G"
  cores    = 2
  vm-id    = "106"
  onboot   = true
  memory   = 2048
  macaddr  = "FE:1C:0D:9D:26:70"
  ipaddr   = "192.168.18.45/24"

}


module "k8s-node1" {
  source = "./proxmox-vm"

  vm-name  = "zabbix-server"
  template = "ubuntu-server-focal-30G"
  cores    = 2
  vm-id    = "106"
  onboot   = true
  memory   = 2048
  macaddr  = "FE:1C:0D:9D:26:71"
  ipaddr   = "192.168.18.46/24"

}


module "k8s-node2" {
  source = "./proxmox-vm"

  vm-name  = "zabbix-server"
  template = "ubuntu-server-focal-30G"
  cores    = 2
  vm-id    = "106"
  onboot   = true
  memory   = 2048
  macaddr  = "FE:1C:0D:9D:26:72"
  ipaddr   = "192.168.18.47/24"

}



