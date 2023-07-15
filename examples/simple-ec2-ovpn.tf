module "ec2-openvpn" {
  source = "rizkiprass/ec2-openvpn-as/aws"
#  version = "~>0.5.0"

  name = format("%s-%s-openvpn", var.project, var.environment)

  instance_type                 = "t3.micro"
  key_name                      = ""
  iam_instance_profile          = aws_iam_instance_profile.ssm-profile.name
  vpc_id                        = "vpc-03a2efb168f8a4c70"
  subnet_id                     = "subnet-026a99e257d62416c"
  #Configuration of OpenVPN-AS
  user_openvpn = "user-1"
#  ip_address_ec2 = ""

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
  name_prefix        = format("%s-ssm-core-role", var.project)
  assume_role_policy = <<POLICY
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ec2.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
POLICY
  tags = merge(local.common_tags, {
    Name = format("%s-ssm-core-role", var.project)
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
  name = format("%s-ssm-profile", var.project)
  role = aws_iam_role.ssm-core-role.name
}