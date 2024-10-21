terraform {
  backend "s3" {
    bucket         = "aybjax-test-tf-state"
    key            = "rs/Task3"
    region         = "eu-central-1"
    dynamodb_table = "aybjax-test-tf-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.71"
    }
  }
}

provider "aws" {
  region = var.region
}