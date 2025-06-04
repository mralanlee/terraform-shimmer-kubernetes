resource "proxmox_lxc" "k8s_master" {
  for_each = var.controlplane_nodes

  target_node  = each.value.target_node
  hostname     = each.key
  ostemplate   = var.lxc_template
  password     = "kubernetes"
  unprivileged = true

  cores  = each.value.cores
  memory = each.value.memory
  swap   = each.value.swap

  rootfs {
    storage = "local-lvm"
    size    = each.value.disk_size
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

  ssh_public_keys = var.ssh_pub_key

  start = true

  tags = "terraform;k8s;controlplane;lxc"
}
