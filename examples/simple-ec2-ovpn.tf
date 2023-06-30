#locals {
#  openvpn_name = format("%s-%s-openvpn", var.customer, var.environment)
#}

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

################################################################################
# Supporting Resources
################################################################################

#Create Role ssm core role
resource "aws_iam_role" "ssm-core-role" {
  name_prefix        = format("%s-ssm-core-role", var.customer)
  assume_role_policy = file("template/assumepolicy.json")
  tags = merge(local.common_tags, {
    Name = format("%s-ssm-core-role", var.customer)
  })
}

#Attach Policy SSMCore
resource "aws_iam_role_policy_attachment" "ssmcore-attach-ssmcore" {
  role       = aws_iam_role.ssm-core-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#Attach Policy CloudWatch
resource "aws_iam_role_policy_attachment" "ssmcore-attach-cwatch" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ssm-core-role.name
}

#Instance Profile ssm
resource "aws_iam_instance_profile" "ssm-profile" {
  name = format("%s-ssm-profile", var.customer)
  role = aws_iam_role.ssm-core-role.name
}