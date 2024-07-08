variable "resize_disks" {
  description = "Whether to resize VM's disks. Disk image will be created as the cloud image size by default"
  type        = bool
  default     = false
}

variable "vm_configs" {
  description = "List of VM configurations"
  type = map(object({
    name	= string
    hostname	= string
    domain	= string
    memory 	= number
    vcpu   	= number
    disk_size 	= string
    ip     	= string
  }))
  default = {
    m1 = {
      name   = "kcl3-m1"
      hostname = "kcl3-m1"
      domain = "codeware.local"
      memory = 2048
      vcpu   = 2
      disk_size = "16G"
      ip     = "192.168.0.121"
    }
    m2 = {
      name   = "kcl3-m2"
      hostname = "kcl3-m2"
      domain = "codeware.local"
      memory = 2048
      vcpu   = 2
      disk_size = "16G"
      ip     = "192.168.0.122"
    }
    m3 = {   
      name   = "kcl3-m3"
      hostname = "kcl3-m3"
      domain = "codeware.local"
      memory = 2048
      vcpu   = 2
      disk_size = "16G"
      ip     = "192.168.0.123"
    }
    w1 = {
      name   = "kcl3-w1"
      hostname = "kcl3-w1"
      domain = "codeware.local"
      memory = 2048
      vcpu   = 2
      disk_size = "16G"
      ip     = "192.168.0.124"
    }
    w2 = {
      name   = "kcl3-w2"
      hostname = "kcl3-w2"
      domain = "codeware.local"
      memory = 2048
      vcpu   = 2
      disk_size = "16G"
      ip     = "192.168.0.125"
    }
  }
}
