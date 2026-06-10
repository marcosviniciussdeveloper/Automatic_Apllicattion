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
  default     = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
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
  default     = "1.30"
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
    Environment = "Prod"
    project     = "DesafioDevOps"
  }
}


