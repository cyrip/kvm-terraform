locals {
  domain = "kcl3"
}

variable "domain" {
  description = "Machines are in this domain"
  default     = "kcl3"
}

variable "libvirt_disk_path" {
  description = "path for libvirt pool"
  default     = "/srv/kvm/pools/kcl3"
}

variable "network_interface" {
  description = "The name of the bridge interface"
  type        = string
  default     = "br0"
}

variable "kvm_network" {
  description = "The name of the bridge interface"
  type        = string
  default     = "br0-default"
}

variable "cloud_image_url" {
  description = "Cloud image for install"
#  default      = "file:///tmp/fedora-coreos-40.20240519.3.0-qemu.x86_64.qcow2"
  default     = "https://cdimage.debian.org/images/cloud/trixie/daily/latest/debian-13-generic-amd64-daily.qcow2"
#  default     = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
#  default     = "http://cloud-images.ubuntu.com/releases/bionic/release-20191008/ubuntu-22.04-server-cloudimg-amd64.img"
}
