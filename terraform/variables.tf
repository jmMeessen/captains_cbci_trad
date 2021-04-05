variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "aws_profile" {
  type    = string
  default = "cloudbees-ps"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default     = "10.0.1.0/24"
}

variable "domain_name" {
  description = "the base domain name when setting up the domain"
  default     = "the-captains-shack.com"
}

variable "jenkins_subdomain" {
  description = "the subdomain to add to domain_name"
  default     = "jenkins"
}

variable "cjoc_subdomain" {
  description = "the CJOC subdomain to add to domain_name"
  default     = "cjoc"
}

variable "cm1_subdomain" {
  description = "the CM1 subdomain to add to domain_name"
  default     = "cm1"
}

variable "internal_domain_name" {
  description = "the base domain name for the internal DNS"
  default     = "the-captains-shack.internal"
}