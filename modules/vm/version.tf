terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.3.0"
    }
  }
  required_version = ">= 0.13"
}
provider "proxmox" {
  pm_api_url      = local.proxmox_api_url
  pm_tls_insecure = true

  pm_api_token_id     = local.proxmox_api_token_id
  pm_api_token_secret = local.proxmox_api_token_secret
}

