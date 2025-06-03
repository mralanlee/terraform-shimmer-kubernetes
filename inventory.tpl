all:
  children:
    masters:
      hosts:
%{ for hostname, ip in master_ips ~}
        ${ip}:
          ansible_user: root
          ansible_ssh_private_key_file: ~/.ssh/k8s_key
          k8s_hostname: ${hostname}
%{ endfor ~}
    workers:
      hosts:
%{ for hostname, ip in worker_ips ~}
        ${ip}:
          ansible_user: debian
          ansible_ssh_private_key_file: ~/.ssh/k8s_key
          ansible_become: yes
          k8s_hostname: ${hostname}
%{ endfor ~}
  vars:
    ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
