# Homelab Management

This repository contains Ansible configurations and playbooks designed to provision and maintain a homelab environment.

**Note:** These instructions are a preliminary draft and have not yet been fully verified.

## Prerequisites

For the best results, it is recommended to use the latest Long Term Support (LTS) versions of the following operating systems:
* **Debian**: Latest LTS (e.g., Debian 13/Trixie)
* **Raspberry Pi OS**

## Configuration

This repository excludes several files. Create these files with your specific environment values to match your homelab.

### Inventory (`hosts.yaml`)
An Ansible inventory file defining groups for Debian, Raspberry Pi, and Kubernetes nodes.

```
all:
  vars:
    ansible_user: ansible
    ansible_python_interpreter: /usr/bin/python3

raspberry_pi_os:
  hosts:
    rasp1:
    rasp2:
    rasp3:

debian:
  hosts:
    deb1:

kube_prime_node:
  hosts:
    rasp1:

kube_secondary_nodes:
  hosts:
    rasp2:
    rasp3:

kube_control_plane_nodes:
  hosts:
    rasp1:
    rasp2:
    rasp3:

kube_worker_nodes:
  hosts:
    deb1:

kube_nodes:
  children:
    kube_control_plane_nodes:
    kube_worker_nodes:
```

### SSH Keys (`ssh-keys.yaml`)
A file used to store your public SSH key for the Ansible user.

```
ansible_ssh_key_pub: ssh-ed25519 xxxxx me@computer
```

### K3s Variables (`k3s-vars.yaml`)
A file for configuring K3s installation on control plane nodes.

```
k3s_token: CHANGME
k3s_primary_ip: 192.168.2.2
```

## Initial Setup

Before Ansible can manage your nodes, you must perform a basic bootstrap to ensure Python is installed and SSH keys are configured.

### 1. Install Python via Raw Commands

Ansible requires Python to function. Use the following `raw` commands to install `python3` on your target nodes.

```#!/bin/sh
ansible debian -m raw -a "apt update && apt install python3" -k -K -b

ansible raspberry_pi_os -m raw -a "apt update && apt install python3" -k -K -b
```

> **Note on flags:**
> * `-k`: Ask for SSH password.
> * `-K`: Ask for sudo password.
> * `-b`: Use `become` (sudo).

### 2. Run Bootstrap Playbooks

Once Python is installed, run the bootstrap playbooks to install your public SSH key, enabling passwordless access for Ansible.

```#!/bin/sh
ansible-playbook -k -K playbooks/bootstrap-debian.yaml

ansible-playbook -k -K playbooks/bootstrap-raspberry.yaml
```

After these steps are complete, you should be able to use Ansible normally.

## Installing k3s

Run the following playbooks in this specific order to complete the k3s installation:

1. **Install prerequisites:** Install the packages required for k3s.
```#!/bin/sh
ansible-playbook playbooks/k3s-init.yaml
```

2. **Deploy Control Plane:** Install k3s on the control plane nodes.
```#!/bin/sh
ansible-playbook playbooks/k3s-control-plane.yaml
```

3. **Deploy Worker Nodes:** Install k3s on the worker nodes.
```#!/bin/sh
ansible-playbook playbooks/k3s-workers.yaml
```

## Development

To ensure a consistent environment, use the remote development container image: `ghcr.io/amills1037/homelab-devel`.

## Notes

<!--`bgp/kubernetes-bgp.conf` allows MetalLB to update routes for load balancers.

kubectl create configmap -n novel-deeds ssh-authorized-keys --from-literal=authorized_keys="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMeMHZ3yiPRM7Q9CCbEOxq+kryuzh5o47pCOOV6JIApp amills@Mac"

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  template:
    spec:
      containers:
      - name: web-app
        image: nginx
        volumeMounts:
        - name: nfs-storage
          mountPath: /var/www/html
          subPath: html-files # 👈 This folder is automatically created inside the NFS share root
      volumes:
      - name: nfs-storage
        persistentVolumeClaim:
          claimName: my-nfs-pvc-->

Add tolerations when adding
