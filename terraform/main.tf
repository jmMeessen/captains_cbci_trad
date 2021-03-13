terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "0.10.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "ovh" {
  endpoint = "ovh-eu"
}