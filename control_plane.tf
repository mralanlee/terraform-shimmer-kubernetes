resource "proxmox_virtual_environment_container" "k8s_master" {
  for_each = var.controlplane_nodes

  node_name = each.value.target_node

  initialization {
    hostname = each.key

    user_account {
      keys     = [var.ssh_pub_key]
      password = "kubernetes"
    }
  }

  network_interface {
    name    = "eth0"
    bridge  = "vmbr0"
    enabled = true
  }

  operating_system {
    template_file_id = var.lxc_template
    type             = "debian"
  }

  cpu {
    cores = each.value.cores
  }

  memory {
    dedicated = each.value.memory
    swap      = each.value.swap
  }

  disk {
    datastore_id = "local-lvm"
    size         = tonumber(replace(each.value.disk_size, "G", ""))
  }

  features {
    nesting = true
  }

  tags = ["terraform", "k8s", "controlplane", "lxc"]

  started      = true
  unprivileged = true
}
