terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.0"
    }
  }

  backend "s3" {
    bucket = "cedric-test-infotech"
    key    = "state.tfstate"
    region = "us-west-1"
  }
}

provider "aws" {
  region  = var.region
}