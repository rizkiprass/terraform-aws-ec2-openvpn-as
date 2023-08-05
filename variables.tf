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

variable "ami" {
  description = "ID of AMI to use for the OpenVPN instance"
  type        = string
  default     = null
}

variable "create_ami" {
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

variable "ec2_subnet_id" {
  description = "The place of subnet Openvpn-AS EC2"
  type        = string
  default     = null
}

variable "user_openvpn" {
  description = "Additional username for login to Openvpn-AS"
  type = string
  default = null
}

variable "routing_ip" {
  description = "The private subnets that your clients need to access. Use an IP CIDR range"
  type = string
  default = null
}

variable "ec2_public_ip" {
  description = "Public IP Address of EC2 which VPN clients use to connect to the Access Server"
  type = string
  default = ""
}