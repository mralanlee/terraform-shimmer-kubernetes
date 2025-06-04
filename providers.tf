terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.78"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

locals {
  proxmox_api_url = "https://${var.proxmox_host}:8006/api2/json"
}

provider "proxmox" {
  endpoint = local.proxmox_api_url
  username = var.proxmox_user
  password = var.proxmox_password
  inseucre = true

  ssh {
    agent    = true
    username = "root"
  }
}
