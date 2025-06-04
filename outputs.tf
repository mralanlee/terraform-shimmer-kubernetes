output "master_ips" {
  value = {
    for k, v in proxmox_virtual_environment_container.k8s_master : k => length(v.ipv4_addresses) > 0 ? v.ipv4_addresses[0] : "pending"
  }
}

output "worker_ips" {
  value = {
    for k, v in proxmox_virtual_environment_vm.k8s_worker : k => length(v.ipv4_addresses) > 1 ? v.ipv4_addresses[1][0] : "pending"
  }
}
