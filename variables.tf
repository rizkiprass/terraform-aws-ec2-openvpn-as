variable "name" {
  description = "Name to be used on OpenVPN instance created"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "ami_custom" {
  description = "ID of AMI to use for the OpenVPN instance"
  type        = string
  default     = null
}

variable "ami" {
  description = "ID of AMI to use for the OpenVPN instance"
  type        = bool
  default     = true
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "iam_instance_profile" {
  description = "IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile"
  type        = string
  default     = null
}

variable "vpc_id" {
  type = string
  default = null
}

variable "create_vpc_security_group_ids" {
  description = "Determines whether an SG is created or to use an existing SG"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = null
}