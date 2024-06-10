variable "ssh_username" {
  description = "the ssh user to use"
  default     = "ubuntu"
}

variable "default_user_password" {
  description = "Default user password hash"
  type = string
  sensitive = true
}

variable "ansible_ssh_public_key" {
  description = "Ansible SSH public key"
  type        = string
  sensitive   = true
}
