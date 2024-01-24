terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "ctf-vpc" {
    id = var.vpc_id
}

data "aws_subnet" "ctf-subnet" {
    id = var.subnet_id
}

#data "aws_security_group" "ctf-secgroup" {
#    id = var.security_group_id
#}

resource "tls_private_key" "ctf-priv-key" {
    algorithm = "ED25519"
}

resource "aws_key_pair" "ctf-pub-key" {
    key_name = "ctf-root-key"
    public_key = tls_private_key.ctf-priv-key.public_key_openssh
}

resource "local_sensitive_file" "ctf-privkey-out" {
    filename = "./.ssh/id_rsa"
    file_permission = "0600"
    content = tls_private_key.ctf-priv-key.private_key_openssh
}

resource "local_file" "ctf-pubkey-out" {
    filename = "./.ssh/id_rsa.pub"
    file_permission = "0644"
    content = tls_private_key.ctf-priv-key.public_key_openssh
}

resource "aws_security_group" "ctf-ec2-secgrp" {
    vpc_id = data.aws_vpc.ctf-vpc.id
    tags = {
        Name = "ctf-EC2-SG"
    }
}

resource "aws_vpc_security_group_egress_rule" "ctf-allow-all" {
    security_group_id = aws_security_group.ctf-ec2-secgrp.id
    description = "Allow all outbound traffic"

    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "ctf-ssh-whitelist" {
    security_group_id = aws_security_group.ctf-ec2-secgrp.id
    description = "Add SSH whitelist for admin IP block"

    cidr_ipv4   = var.admin_ips
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "ctf-allow-almost-all1" {
    security_group_id = aws_security_group.ctf-ec2-secgrp.id
    description = "Allow all non-ssh traffic from internet"

    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port   = 0
    to_port     = 21
}

resource "aws_vpc_security_group_ingress_rule" "ctf-allow-almost-all2" {
    security_group_id = aws_security_group.ctf-ec2-secgrp.id
    description = "Allow all non-ssh traffic from internet"

    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = "tcp"
    from_port   = 23
    to_port     = 65535
}