resource "proxmox_virtual_environment_vm" "k8s_worker" {
  for_each = var.worker_nodes

  name      = each.key
  node_name = each.value.target_node
  vm_id     = null # Auto-assign

  agent {
    enabled = true
  }

  cpu {
    cores   = each.value.cores
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = each.value.memory
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = "local:iso/debian-12-generic-amd64.img" # Reference to template
    interface    = "virtio0"
    iothread     = true
    size         = each.value.disk_size
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_account {
      username = "debian"
      keys     = [var.ssh_pub_key]
    }
  }

  tags = ["terraform", "k8s", "worker", "vm"]
}
