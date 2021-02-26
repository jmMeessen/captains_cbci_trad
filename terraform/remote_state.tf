#backend make sure to change bucket name 
terraform {
  backend "s3" {
    bucket = "terraform.jmm.eu"
    key    = "terraform/jmm/captains_cbci_trad.tfstate"
    region = "us-east-1"
  }
}

