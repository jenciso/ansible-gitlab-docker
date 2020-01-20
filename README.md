## GITLAB

Ansible playbook to provision a gitlab server running on docker

### PROVISION

clone this [repo](https://github.com/jenciso/kvm-provision) to create a VM.

```
./new-vm.sh -n gitlab -m 4096 -c 2 -i 192.168.122.41
```

### PRE-INSTALL

This step are needed to run our ssh server on TCP 2222. Gitlan will be use TCP 22

```
ansible -m lineinfile \
  -a "path=/etc/ssh/sshd_config regexp='^#Port 22' line='Port 2222'" \
  -i inventory -e "ansible_port=22" gitlab -u centos

ansible -m seport \
  -a "ports=2222 proto=tcp setype=ssh_port_t state=present" \
  -i inventory -e "ansible_port=22" gitlab -u centos

ansible -m systemd \
  -a "name=sshd state=restarted" \
  -i inventory -e "ansible_port=22" gitlab -u centos
```

### INSTALL

```
ansible-playbook site-common.yml -i inventory
ansible-playbook site.yml -i inventory
```

