variable "name" {
  default = "public"
}

variable "cidrs" {
  description = "List of VPC CIDR blocks"
  type        = list
  default     = []
}

variable "zones" {
  description = "A list of availability zones"
  type        = list
  default     = []
}

variable "vpc_id" {
  description = "VPC id"
}

variable "igw_id" {
  description = "Internet gateway id"
}

variable "map_public_ip_on_launch" {
  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  default     = true
}

variable "propagating_vgws" {
  description = "A list of virtual gateways for propagation."
  type        = list
  default     = []
}

variable "env" {
  description = "Logical environment as it relates to the Shutterfly software release lifecycle (e.g. dev, stage, prod)."
}

