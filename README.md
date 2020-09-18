## GITLAB SERVER

This is an ansible playbook will create a gitlab server using docker-compose to running it.

### Provision

Clone this [repo](https://github.com/jenciso/kvm-provision) and create a VM using this command:

```
./new-vm.sh -n gitlab -m 4096 -c 2 -i 192.168.122.41
```

### Pre-install

We need to run these commands in order to run our sshd on TCP 2222. So, our gitlab server will be use the tcp port 22

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

### Install

```
ansible-playbook site-common.yml -i inventory -e deploy_docker=true
ansible-playbook site.yml -i inventory
```
