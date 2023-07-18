# terraform-aws-ec2-openvpn-as
Terraform module which creates EC2 resources with OpenVPN AS (Access Server) installed on AWS

## Overview
The terraform-aws-ec2-openvpn-as module is designed to simplify the process of deploying an EC2 instance with OpenVPN Access Server installed on the AWS cloud platform. This module takes care of creating the necessary resources and configurations, allowing you to quickly set up a secure and scalable OpenVPN environment.


## Example Usages
### Simple EC2-OpenVPN
The following example demonstrates the basic usage of the ec2-openvpn module:

```hcl
module "ec2-openvpn" {
  source = "rizkiprass/ec2-openvpn-as/aws"

  name = format("%s-%s-openvpn", var.project, var.environment)

  instance_type = "t3.micro"
  key_name      = ""
  vpc_id        = aws_vpc.vpc.id
  ec2_subnet_id = aws_subnet.public-subnet-3a.id
  user_openvpn  = "user-1"
  routing_ip    = "172.31.0.0/16"

  tags = merge(local.common_tags, {
    OS     = "Ubuntu",
    Backup = "DailyBackup"
  })
}
```
### Complete EC2-OpenVPN
For more advanced configurations, you can use the complete example below:
```hcl
module "ec2-openvpn" {
  source = "rizkiprass/ec2-openvpn-as/aws"

  name                          = format("%s-%s-openvpn", var.project, var.environment)
  create_ami                    = false
  ami_id                        = "xxxxxx"
  instance_type                 = "t3.micro"
  key_name                      = ""
  vpc_id                        = aws_vpc.vpc.id
  ec2_subnet_id                 = aws_subnet.public-subnet-3a.id
  user_openvpn                  = "user-1"
  routing_ip                    = "172.31.0.0/16"
  create_vpc_security_group_ids = false
  vpc_security_group_ids        = "xxxxx"
  iam_instance_profile          = aws_iam_instance_profile.ssm-profile.name

  tags = merge(local.common_tags, {
    OS     = "Ubuntu",
    Backup = "DailyBackup"
  })
}
```
## Inputs

| Name                              | Description                                                                                      | Type        | Default    | Required |
| --------------------------------- | ------------------------------------------------------------------------------------------------ | ----------- | ---------- | -------- |
| name                              | The name to be used for the OpenVPN instance created.                                             | string      | ""         | Yes      |
| instance_type                     | The type of instance to start.                                                                   | string      | "t3.micro" | Yes      |
| key_name                          | Key name of the Key Pair to use for the instance. Leave it empty for no SSH access.             | string      | ""         | No       |
| vpc_id                            | The ID of the VPC where the EC2 instance will be deployed.                                       | string      | -          | Yes      |
| ec2_subnet_id                     | The ID of the subnet within the VPC where the EC2 instance will reside.                          | string      | -          | Yes      |
| user_openvpn                      | An additional username for logging in to the OpenVPN Access Server.                              | string      | -          | Yes      |
| routing_ip                        | The private subnets that your clients need to access. Use an IP CIDR range, e.g., "172.31.0.0/16".| string      | -          | Yes      |
| create_vpc_security_group_ids     | Determines whether an SG is created or to use an existing SG.                                    | bool        | true       | No       |
| vpc_security_group_ids            | A list of security group IDs to associate with.                                                  | list(string)| null       | No       |
| ami                               | ID of AMI to use for the OpenVPN instance.                                                        | string      | null       | No       |
| create_ami                        | Determines whether to create an AMI or use an existing one.                                      | bool        | true       | No       |
| iam_instance_profile              | IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile. | string      | null       | No       |
| ec2_public_ip                     | Public IP Address of EC2, which VPN clients use to connect to the Access Server.                 | string      | ""         | No       |

For a complete list of input variables and their descriptions, refer to the [variables.tf](variables.tf) file.

## Authors
This Terraform module is authored and maintained by rizkiprass.

Feel free to contribute by submitting issues, feature requests, or pull requests on GitHub.

## Supports
For any questions, issues, or feedback, please contact rizkiprasetyapras@gmail.com.

## Acknowledgments
Special thanks to the Terraform community for their contributions and inspiration.  