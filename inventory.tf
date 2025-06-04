resource "local_file" "ansible_inventory" {
  content = yamlencode({
    all = {
      children = {
        controlplane = {
          hosts = {
            for k, v in proxmox_virtual_environment_container.k8s_master : k => {
              ansible_host                 = length(v.ipv4_addresses) > 0 ? v.ipv4_addresses[0] : "pending"
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
