# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# AWS Credentials (for use with provider if not using environment variables)
variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "aws_session_token" {
  description = "AWS Session Token (if using temporary credentials)"
  type        = string
  sensitive   = true
}

# VPC Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Public Subnets
variable "public_subnet_az1_cidr" {
  description = "CIDR block for the public subnet in AZ1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for the public subnet in AZ2"
  type        = string
  default     = "10.0.2.0/24"
}

# Private Subnets
variable "private_subnet_az1_cidr" {
  description = "CIDR block for the private subnet in AZ1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_az2_cidr" {
  description = "CIDR block for the private subnet in AZ2"
  type        = string
  default     = "10.0.4.0/24"
}
