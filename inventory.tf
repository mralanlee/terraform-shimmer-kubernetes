resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.yml.tpl", {
    controlplane_nodes = {
      for k, v in proxmox_virtual_environment_container.k8s_master : k => v.ipv4_addresses[0]
    }
    worker_nodes = {
      for k, v in proxmox_virtual_environment_vm.k8s_worker : k => v.ipv4_addresses[1][0]
    }
  })
  filename = "./inventory.yml"
}
