## GITLAB

Ansible playbook to provision gitlab docker version

### PROVISION

Provisionar via `kvm-provision`

### PRE-INSTALL

```
ansible -m lineinfile -a "path=/etc/ssh/sshd_config regexp='^#Port 22' line='Port 2222'" -i inventory -e "ansible_port=22" gitlab -u centos
ansible -m seport -a "ports=2222 proto=tcp setype=ssh_port_t state=present" -i inventory -e "ansible_port=22" gitlab -u centos
ansible -m systemd -a "name=sshd state=restarted" -i inventory -e "ansible_port=22" gitlab -u centos
```

### INSTALL

```
ansible-playbook site-common.yml -i inventory
ansible-playbook site.yml -i inventory
```


