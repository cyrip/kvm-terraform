resource "libvirt_pool" "libvirt-pool" {
  name = "${var.domain}-pool"
  type = "dir"
  path = var.libvirt_disk_path
}

resource "libvirt_volume" "libvirt-volumes" {
  for_each = var.vm_configs
  name     = "${each.value.name}.qcow2"
  format   = "qcow2"
  pool     = libvirt_pool.libvirt-pool.name
  source = var.cloud_image_url
}

data "template_file" "network_config" {
  for_each = var.vm_configs
  template = file("${path.module}/cloud-config/network_config.cfg")
  vars = {
    ip         = each.value.ip
    gateway4   = var.net_default_gateway4
    nameservers= var.net_nameservers
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  for_each 	 = var.vm_configs
  name     	 = "commoninit_${each.value.name}.iso"
  user_data	 = data.template_cloudinit_config.config[each.key].rendered
  network_config = data.template_file.network_config[each.key].rendered
  pool      	 = libvirt_pool.libvirt-pool.name
}

data "template_cloudinit_config" "config" {
  for_each = var.vm_configs
  gzip          = false
  base64_encode = false

  part {
    filename     = "user-data"
    content_type = "text/cloud-config"
    content      = <<EOF

manage-resolv-conf: true

hostname: ${each.value.hostname}
fqdn: ${each.value.hostname}.${each.value.domain}
users:
  - name: ubuntu
    gecos: "Ubuntu User"
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    groups: sudo
    lock_passwd: false
    passwd: ${var.default_user_password}
    ssh_authorized_keys:
      - ${var.ansible_ssh_public_key}

chpasswd:
  list: |
     root:${var.default_user_password}
  expire: false

runcmd:
  - apt-get update
  - apt-get install -y qemu-guest-agent
EOF
  }
}

resource "libvirt_domain" "libvirt-domain" {
  for_each = var.vm_configs
  name     = each.value.name
  memory   = each.value.memory
  vcpu     = each.value.vcpu

  cloudinit = libvirt_cloudinit_disk.commoninit[each.key].id

  disk {
    volume_id = libvirt_volume.libvirt-volumes[each.key].id
  }

#  disk {
#    volume_id = libvirt_volume.libvirt-boot-isos[each.key].id
#  }

  network_interface {
    network_name = var.kvm_network
    wait_for_lease = false
  }
  
  console {
    type        = "tcp"
    target_type = "virtio"
    target_port = "1"
  }
  
  graphics {
    type = "vnc"
    autoport = "true"
    listen_type = "address"
  }
}

resource "null_resource" "resize_disk" {
  for_each = var.resize_disks ? var.vm_configs : {}
  provisioner "local-exec" {
    command = <<EOT
      sleep 20
      sudo virsh shutdown ${each.value.name}
      sleep 10
      sudo virsh domstate ${each.value.name}
      sleep 10
      sudo qemu-img resize "${var.libvirt_disk_path}/${each.value.name}.qcow2" "${each.value.disk_size}"
      sudo virsh start ${each.value.name}
    EOT
  }

  depends_on = [libvirt_domain.libvirt-domain]
}
