terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.aws_vpc_name
  cidr = var.aws_vpc_cidr

  azs             = var.aws_vpc_azs
  private_subnets = var.aws_vpc_private_subnets
  public_subnets  = var.aws_vpc_public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = var.aws_project_tags
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.23.0"

  cluster_name    = var.aws_eks_name
  cluster_version = var.aws_eks_version

  enable_cluster_creator_admin_permissions = true

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id # FIXED: Changed from module.vpc.default_vpc_id to module.vpc.vpc_id

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      min_size     = 2
      max_size     = 2
      desired_size = 2

      instance_types = tolist(var.aws_managed_node_groups_instance_type) # FIXED: changed instance_type to instance_types
    }
  }
}

variable "aws_region" {
  description = "Região usada para criar os recursos da aws"
  type        = string
  nullable    = false
  default     = "us-east-1"
}

variable "aws_vpc_name" {
  description = "Nome da vpc"
  type        = string
  nullable    = false
  default     = "DevOpsVpc"
}

variable "aws_vpc_cidr" {
  description = "Incluir os blocos de ips da vpc"
  type        = string
  nullable    = false
  default     = "10.0.0.0/16"
}

variable "aws_vpc_azs" {
  description = "Zonas de disponibilidade da vpc"
  type        = set(string)
  nullable    = false
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "aws_vpc_private_subnets" {
  description = "Guardar as subnets privadas"
  type        = set(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "aws_vpc_public_subnets" {
  description = "Guardar as subnets publicas"
  type        = set(string)
  nullable    = false
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "aws_eks_name" {
  description = "Nome para os conteiners EKS"
  type        = string
  nullable    = false
  default     = "DesafioDevOps"
}

variable "aws_eks_version" {
  description = "Guarda a versão do EKS"
  type        = string
  nullable    = false
  default     = "1.29"
}

variable "aws_managed_node_groups_instance_type" {
  description = "Guarda os node do nosso EKS"
  type        = set(string)
  nullable    = false
  default     = ["t3.small"]
}

variable "aws_project_tags" {
  description = "Incluir as tags do projeto para facilitar a localização do recurso"
  type        = map(any)
  nullable    = false
  default = {
    terraform   = "true"
    Environment = "Prod" # FIXED: Typo from Enviroment to Environment
    project     = "DesafioDevOps"
  }
}
