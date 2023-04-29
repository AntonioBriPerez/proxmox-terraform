

module "zabbix-server" {
  source = "./proxmox-vm"

  vm-name  = "zabbix-server"
  template = "ubuntu-server-focal-30G"
  cores    = 2
  vm-id    = "106"
  onboot   = true
  memory   = 2048
  macaddr  = "FE:1C:0D:9D:26:67"
  ipaddr   = "192.168.18.42/24"

}



