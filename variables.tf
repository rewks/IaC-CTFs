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

variable "security_group_id" {
    description = "The id of the security group to be applied to the resources"
    type = string
}

variable "admin_ips" {
    description = "CIDR IP range for administrative access"
    type = string
}