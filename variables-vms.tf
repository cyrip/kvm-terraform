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
    vm1 = {
      name   = "uvm1"
      hostname = "uvm1"
      domain = "codeware.local"
      memory = 512
      vcpu   = 1
      disk_size = "4G"
      ip     = "192.168.0.51"
    }
    vm2 = {
      name   = "uvm2"
      hostname = "uvm2"
      domain = "codeware.local"
      memory = 512
      vcpu   = 2
      disk_size = "4G"
      ip     = "192.168.0.52"
    }
  }
}
