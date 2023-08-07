<div style="display: flex; justify-content: center;">
  <div>
    <img src="./images/openvpn-as-banner.png" alt="OpenvpnAS" style="width: 300px;">
  </div>
</div>

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

  name                          = "Openvpn Access Server"
  create_ami                    = true
  create_vpc_security_group_ids = true
  instance_type                 = "t3.micro"
  key_name                      = ""
  vpc_id                        = aws_vpc.vpc.id
  ec2_subnet_id                 = aws_subnet.public-subnet-3a.id
  user_openvpn                  = "user-1"
  routing_ip                    = "172.31.0.0/16"

  tags = merge(local.common_tags, {
    OS = "Ubuntu",
  })
}
```
### Complete EC2-OpenVPN
For more configurations, you can use the complete example below:
```hcl
module "ec2-openvpn" {
  source = "rizkiprass/ec2-openvpn-as/aws"

  name                          = "Openvpn Access Server"
  ami_id                        = "xxxxxx"
  instance_type                 = "t3.micro"
  key_name                      = ""
  vpc_id                        = aws_vpc.vpc.id
  ec2_subnet_id                 = aws_subnet.public-subnet-3a.id
  user_openvpn                  = "user-1"
  routing_ip                    = "172.31.0.0/16"
  vpc_security_group_ids        = ["xxxxx"]
  iam_instance_profile          = aws_iam_instance_profile.ssm-profile.name

  tags = merge(local.common_tags, {
    OS = "Ubuntu",
  })
}
```
## How to Connect to OpenVPN Access Server

1. After successfully deploying the OpenVPN Access Server module, log in to your server using SSH or any other method.

2. Once you are logged in, navigate to the following location to find the OpenVPN Access Server user admin credentials:
`/home/ubuntu/user-admin-pass.txt`
Open the file to view the username and password for the OpenVPN Access Server admin.
3. For additional users, you can find their credentials at the following location: `/home/ubuntu/user1-password.txt`
4. Download the OpenVPN Connect application if you haven't already. You can get it from the official OpenVPN website by clicking [here](https://openvpn.net/client/client-connect-vpn-for-windows/).

5. Once the OpenVPN Connect application is installed, open it on your device.

6. To import the OpenVPN profile, follow these steps:

    a. Click on the "+" icon in the OpenVPN Connect application to add a new profile.

    b. Enter the URL of your OpenVPN Access Server. The URL should be in the following format, replacing `<your ip public ec2>` with the public IP address of your EC2 instance: `https://<your ip public ec2>`

    c. Click "Add" to import the profile.

7. You will be prompted to enter the username and password that you obtained in step 2 for the OpenVPN Access Server admin.

8. Once you've entered the admin credentials, the OpenVPN profile will be imported, and you will be connected to the OpenVPN Access Server.

9. Now you can access your private network securely through the OpenVPN connection.

That's it! You are now connected to your OpenVPN Access Server, and your data is encrypted and transmitted securely. If you encounter any issues, double-check your credentials and the URL you entered in the OpenVPN Connect application.

## Inputs

| Name                              | Description                                                                                       | Type        | Default    | Required |
| --------------------------------- |---------------------------------------------------------------------------------------------------| ----------- |------------| -------- |
| name                              | The name to be used for the OpenVPN instance created.                                             | string      | ""         | Yes      |
| instance_type                     | The type of instance to start.                                                                    | string      | "t3.micro" | Yes      |
| key_name                          | Key name of the Key Pair to use for the instance. Leave it empty for no SSH access.               | string      | ""         | No       |
| vpc_id                            | The ID of the VPC where the EC2 instance will be deployed.                                        | string      | -          | Yes      |
| ec2_subnet_id                     | The ID of the subnet within the VPC where the EC2 instance will reside.                           | string      | -          | Yes      |
| user_openvpn                      | An additional username for log in in to the OpenVPN Access Server.                                | string      | -          | Yes      |
| routing_ip                        | The private subnets that your clients need to access. Use an IP CIDR range, e.g., "172.31.0.0/16". | string      | -          | Yes      |
| create_vpc_security_group_ids     | Determines whether an SG is created or to use an existing SG.                                     | bool        | false      | No       |
| vpc_security_group_ids            | A list of security group IDs to associate with the EC2 OpenVPN AS.                                                   | list(string)| null       | No       |
| ami                               | ID of AMI to use for the OpenVPN instance.                                                        | string      | null       | No       |
| create_ami                        | Determines whether an AMI is created or using AMI that you choose.                                       | bool        | false      | No       |
| iam_instance_profile              | IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile.  | string      | null       | No       |
| ec2_public_ip                     | Public IP Address of EC2, which VPN clients use to connect to the Access Server.                  | string      | ""         | No       |

For a complete list of input variables and their descriptions, refer to the [variables.tf](variables.tf) file.

## Authors
This Terraform module is authored and maintained by rizkiprass.

Feel free to contribute by submitting issues, feature requests, or pull requests on GitHub.

## Supports
For any questions, issues, or feedback, please contact rizkiprasetyapras@gmail.com.

## Acknowledgments
Special thanks to the Terraform community for their contributions and inspiration.  
