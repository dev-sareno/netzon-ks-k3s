terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    region = "us-east-1"
    bucket = "netzon-ks-k3s"
    key    = "terraform/terraform.tfstate"
  }
}
