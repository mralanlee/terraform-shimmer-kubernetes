output "master_ips" {
  value = { for k, v in proxmox_lxc.k8s_master : k => v.network[0].ip }
}

output "worker_ips" {
  value = { for k, v in proxmox_vm_qemu.k8s_worker : k => v.default_ipv4_address }
}
