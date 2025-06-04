resource "proxmox_vm_qemu" "k8s_worker" {
  for_each = var.worker_nodes

  name        = each.key
  target_node = each.value.target_node
  clone       = var.vm_template

  cores   = each.value.cores
  sockets = 1
  memory  = each.value.memory

  disk {
    slot    = 0
    size    = each.value.disk_size
    type    = "scsi"
    storage = "local-lvm"
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  cloudinit_cdrom_storage = "local-lvm"
  ipconfig0               = "ip=dhcp"

  ciuser  = "debian"
  sshkeys = var.ssh_pub_key

  lifecycle {
    ignore_changes = [network]
  }

  tags = "terraform;k8s;worker;vm"
}
