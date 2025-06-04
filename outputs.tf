output "master_ips" {
  value = {
    for k, v in proxmox_virtual_environment_container.k8s_master : k => v.ipv4_addresses[0]
  }
}

output "worker_ips" {
  value = {
    for k, v in proxmox_virtual_environment_vm.k8s_worker : k => v.ipv4_addresses[1][0]
  }
}
