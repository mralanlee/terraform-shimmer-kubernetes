# terraform-shimmer-kubernetes
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 2.9.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 2.9.14 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.ansible_inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [proxmox_lxc.k8s_master](https://registry.terraform.io/providers/telmate/proxmox/2.9.14/docs/resources/lxc) | resource |
| [proxmox_vm_qemu.k8s_worker](https://registry.terraform.io/providers/telmate/proxmox/2.9.14/docs/resources/vm_qemu) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_controlplane_nodes"></a> [controlplane\_nodes](#input\_controlplane\_nodes) | Map of control plane nodes with their target Proxmox nodes | <pre>map(object({<br/>    target_node = string<br/>    cores       = optional(number, 2)<br/>    memory      = optional(number, 2048)<br/>    swap        = optional(number, 512)<br/>    disk_size   = optional(string, "8G")<br/>  }))</pre> | <pre>{<br/>  "k8s-master-01": {<br/>    "target_node": "pve"<br/>  },<br/>  "k8s-master-02": {<br/>    "target_node": "pve2"<br/>  },<br/>  "k8s-master-03": {<br/>    "target_node": "singed"<br/>  }<br/>}</pre> | no |
| <a name="input_lxc_template"></a> [lxc\_template](#input\_lxc\_template) | Template for LXC containers | `string` | `"local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"` | no |
| <a name="input_proxmox_host"></a> [proxmox\_host](#input\_proxmox\_host) | Proxmox Host | `string` | n/a | yes |
| <a name="input_proxmox_password"></a> [proxmox\_password](#input\_proxmox\_password) | Password for terraform@pve user | `string` | n/a | yes |
| <a name="input_proxmox_user"></a> [proxmox\_user](#input\_proxmox\_user) | Proxmox user | `string` | `"terraform@pve"` | no |
| <a name="input_ssh_pub_key"></a> [ssh\_pub\_key](#input\_ssh\_pub\_key) | SSH public key for the nodes | `string` | n/a | yes |
| <a name="input_vm_template"></a> [vm\_template](#input\_vm\_template) | Template for VM | `string` | `"debian-cloud-template"` | no |
| <a name="input_worker_nodes"></a> [worker\_nodes](#input\_worker\_nodes) | Map of worker nodes with their target Proxmox nodes | <pre>map(object({<br/>    target_node = string<br/>    cores       = optional(number, 4)<br/>    memory      = optional(number, 4096)<br/>    disk_size   = optional(string, "40G")<br/>  }))</pre> | <pre>{<br/>  "k8s-worker-01": {<br/>    "target_node": "pve"<br/>  },<br/>  "k8s-worker-02": {<br/>    "target_node": "pve2"<br/>  },<br/>  "k8s-worker-03": {<br/>    "target_node": "singed"<br/>  }<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_master_ips"></a> [master\_ips](#output\_master\_ips) | n/a |
| <a name="output_worker_ips"></a> [worker\_ips](#output\_worker\_ips) | n/a |
