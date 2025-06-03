variable "proxmox_user" {
  description = "Proxmox user"
  type        = string
  default     = "terraform@pve"
}

variable "proxmox_password" {
  description = "Password for terraform@pve user"
  type        = string
  sensitive   = true
}

variable "proxmox_host" {
  description = "Proxmox Host"
  type        = string
  sensitive   = true
}

variable "ssh_pub_key" {
  description = "SSH public key for the nodes"
  type        = string
}

variable "lxc_template" {
  description = "Template for LXC containers"
  type        = string
  default     = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
}

variable "vm_template" {
  description = "Template for VM"
  type        = string
  default     = "debian-cloud-template"
}

variable "controlplane_nodes" {
  description = "Map of control plane nodes with their target Proxmox nodes"
  type = map(object({
    target_node = string
    cores       = optional(number, 2)
    memory      = optional(number, 2048)
    swap        = optional(number, 512)
    disk_size   = optional(string, "8G")
  }))
  default = {
    "k8s-master-01" = { target_node = "pve" }
    "k8s-master-02" = { target_node = "pve2" }
    "k8s-master-03" = { target_node = "singed" }
  }
}

variable "worker_nodes" {
  description = "Map of worker nodes with their target Proxmox nodes"
  type = map(object({
    target_node = string
    cores       = optional(number, 4)
    memory      = optional(number, 4096)
    disk_size   = optional(string, "40G")
  }))
  default = {
    "k8s-worker-01" = { target_node = "pve" }
    "k8s-worker-02" = { target_node = "pve2" }
    "k8s-worker-03" = { target_node = "singed" }
  }
}
