# terraform-aws-ec2-openvpn
Terraform module which creates EC2 resources with OpenVPN installed on AWS

## Example
### Simple EC2-OpenVPN

```hcl
module "ec2-openvpn" {
  source = "rizkiprass/ec2-openvpn/aws"

  name = format("%s-%s-openvpn", var.customer, var.environment)

  instance_type                 = "t3.micro"
  key_name                      = "sandbox-key-2"
  iam_instance_profile          = aws_iam_instance_profile.ssm-profile.name
  vpc_id                        = "vpc-06409c7d1459a1aae"
  subnet_id                     = "subnet-057874b9829745a19"

  tags = merge(local.common_tags, {
    OS     = "Ubuntu",
    Backup = "DailyBackup"
  })
}
```
### Customize EC2-OpenVPN
---under development---
