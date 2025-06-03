terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

locals {
  proxmox_api_url = "https://${var.proxmox_host}:8006/api2/json"
}

provider "proxmox" {
  pm_api_url      = local.proxmox_api_url
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = true
}
