provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "wps-terraform-state-bucket"
    key    = "statefile/terraform.tfstate"
    region = "us-east-1"
  }
}