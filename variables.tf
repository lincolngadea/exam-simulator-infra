variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

# Variáveis para a aplicação Elastic Beanstalk
variable "eb_app_name" {
  description = "Elastic Beanstalk Application Name"
  type        = string
}

variable "eb_env_name" {
  description = "Elastic Beanstalk Environment Name"
  type        = string
}

# Outras variáveis (ex.: para RDS)
variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "allowed_cidr" {
  description = "CIDR block allowed to access RDS"
  type        = string
  default     = "0.0.0.0/0"

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.allowed_cidr))
    error_message = "The allowed_cidr variable must be a valid CIDR block."
  }
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string  
}