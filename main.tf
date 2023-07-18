locals {
  vars = {
    user_openvpn = var.user_openvpn
    routing_ip = var.routing_ip
    ec2_public_ip = aws_eip.ovpn_eip.public_ip
  }
}

################################################################################
# Instance
################################################################################
resource "aws_instance" "openvpn" {
  ami                    = var.ami ? data.aws_ami.ubuntu_20.id : var.ami_custom
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.create_vpc_security_group_ids ? [aws_security_group.this[0].id] : var.vpc_security_group_ids
  iam_instance_profile   = var.iam_instance_profile
  user_data              = base64encode(templatefile("${path.module}/scripts/openvpn-as.sh", local.vars))

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    iops                  = 3000
    encrypted             = true
    delete_on_termination = true
    tags                  = merge({ "Name" = var.name }, var.tags)
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = merge({ "Name" = var.name }, var.tags)

  #  tags = merge(local.common_tags, {
  #    Name   = local.openvpn_name,
  #    OS     = "Ubuntu",
  #    Backup = "DailyBackup"
  #  })
}

//AWS Resource for Create EIP OpenVPN
resource "aws_eip" "ovpn_eip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.openvpn.id
  allocation_id = aws_eip.ovpn_eip
}

#test2
################################################################################
# Security Group
################################################################################

resource "aws_security_group" "this" {
  count       = var.create_vpc_security_group_ids ? 1 : 0
  name        = "${var.name}-sg"
  description = "Default security group for OpenVPN"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 1194
    to_port   = 1194
    protocol  = "udp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "point-to-point encrypted tunnels between hosts"
  }

  ingress {
    from_port = 943
    to_port   = 943
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "access web interface"
  }

  ingress {
    from_port = 945
    to_port   = 945
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "connect ovpn client"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "ssh"
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
    description = "https"
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1" //all traffic
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  #  tags = merge(local.common_tags, {
  #    Name = local.sg_openvpn_name
  #  })

  tags = { Terraform = "Yes" }

}

############### data ami #####################
data "aws_ami" "amazon_linux_23" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

data "aws_ami" "ubuntu_20" {
  most_recent = true
  owners      = ["099720109477"] # Canonical account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}