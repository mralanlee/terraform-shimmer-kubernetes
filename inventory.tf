# inventory.tf - Fixed for bpg provider limitations  
# Note: LXC containers don't expose IP addresses in bpg provider yet
resource "local_file" "ansible_inventory" {
  content = yamlencode({
    all = {
      children = {
        controlplane = {
          hosts = {
            for k, v in proxmox_virtual_environment_container.k8s_master : k => {
              ansible_host                 = "TODO-GET-IP-FROM-PROXMOX"
              ansible_user                 = "root"
              ansible_ssh_private_key_file = "~/.ssh/id_rsa"
            }
          }
        }
        workers = {
          hosts = {
            for k, v in proxmox_virtual_environment_vm.k8s_worker : k => {
              ansible_host                 = length(v.ipv4_addresses) > 1 ? v.ipv4_addresses[1][0] : "pending"
              ansible_user                 = "debian"
              ansible_ssh_private_key_file = "~/.ssh/id_rsa"
              ansible_become               = true
            }
          }
        }
        k8s_cluster = {
          children = {
            controlplane = {}
            workers      = {}
          }
        }
      }
    }
  })
  filename = "./inventory.yml"

  depends_on = [
    proxmox_virtual_environment_container.k8s_master,
    proxmox_virtual_environment_vm.k8s_worker
  ]
}

# Create a script to help get LXC IPs manually
resource "local_file" "get_lxc_ips" {
  content  = <<-EOF
#!/bin/bash
# Script to get LXC container IPs from Proxmox
echo "Getting LXC container IPs..."
%{for k, v in var.controlplane_nodes~}
echo "Getting IP for ${k} on node ${v.target_node}..."
ssh root@${v.target_node} "lxc-info -n \$(pct list | grep ${k} | awk '{print \$1}') -iH" 2>/dev/null || echo "Container not found or not running"
%{endfor~}
EOF
  filename = "./get_lxc_ips.sh"

  provisioner "local-exec" {
    command = "chmod +x ./get_lxc_ips.sh"
  }
}
