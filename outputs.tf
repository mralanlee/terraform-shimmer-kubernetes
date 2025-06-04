# outputs.tf - Fixed for bpg provider limitations
# Note: LXC containers don't expose IP addresses in bpg provider yet
output "master_ips" {
  value = {
    for k, v in proxmox_virtual_environment_container.k8s_master : k => "check-proxmox-gui"
  }
  description = "Control plane IPs - check Proxmox GUI as bpg provider doesn't expose LXC IPs yet"
}

output "worker_ips" {
  value = {
    for k, v in proxmox_virtual_environment_vm.k8s_worker : k => length(v.ipv4_addresses) > 1 ? v.ipv4_addresses[1][0] : "pending"
  }
}
