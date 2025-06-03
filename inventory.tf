resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    master_ips = { for k, v in proxmox_lxc.k8s_master : k => v.network[0].ip }
    worker_ips = { for k, v in proxmox_vm_qemu.k8s_worker : k => v.default_ipv4_address }
  })
  filename = "${path.module}/inventory.yml"
}
