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
All 3 current machines: samba, plex and wireguard has the same exact configuration. The code must be refactored but it will be done in the future. 

```hcl


```