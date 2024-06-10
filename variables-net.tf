variable "net_default_gateway4" {
  description = "Default gateway for the guests"
  type        = string
  default     = "192.168.0.1"
}

variable "net_nameservers" {
  description = "Net nameservers for the guests"
  type        = string
  default     = "['192.168.0.1','8.8.4.4', '8.8.8.8']"
}
