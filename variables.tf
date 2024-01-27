variable "aws_region" {
    description = "The region within AWS that resources are to be deployed to"
    type = string
    default = "eu-west-2"
}

variable "vpc_id" {
    description = "The id of the VPC that resources are to be deployed to"
    type = string
}

variable "subnet_id" {
    description = "The id of the subnet that resources are to be deployed to"
    type = string
}

variable "admin_ips" {
    description = "CIDR IP range for administrative access"
    type = string
}

# https://aws.amazon.com/ec2/instance-types/
variable "ec2_size" {
    description = "The size of the EC2 instance to provision"
    type = string
    default = "t3.large"   # 2 core, 8gb ram Intel Xeon
}

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
variable "ec2_ami" {
    description = "The AMI to install on the EC2"
    type = string
    default = "ami-04f699a0349f0bbc9"   # Ubuntu 23.10 amd64 (eu-west-2), 20240123.1
}