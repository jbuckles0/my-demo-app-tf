terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.42.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.94.1"
    }
  }
  required_version = ">= 0.14.5"
}

provider "aws" {
  region = "us-east-2"
}

locals {
  tags = {
    Name = "My Demo App - ${var.environment_tag}"
    Environment = var.environment_tag
    ManagedBy = "terraform"
  }
}

module "vpc" {
  source  = "app.terraform.io/jacobbuckles-org/vpc/aws"
  version = "0.0.2"

  cidr_vpc = "10.1.0.0/16"
  cidr_subnet = "10.1.0.0/24"
  tags = local.tags
}

resource "aws_instance" "web" {
  ami                         = data.hcp_packer_artifact.ubuntu-east.external_identifier
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.subnet_id
  vpc_security_group_ids      = [module.vpc.vpc_security_group_id]
  associate_public_ip_address = true

  tags = local.tags
}


