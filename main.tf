terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.13"
    }
  }
}

variable "proxmox_api_url" {
  type        = string
  description = "URL of the Proxmox API"
}

variable "proxmox_api_token_id" {
  type        = string
  description = "Token ID for the Proxmox API"
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_tls_insecure     = true
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
}
