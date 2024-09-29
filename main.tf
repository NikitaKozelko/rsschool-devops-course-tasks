variable "region" { default = "eu-central-1" }

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "rss-task-1-bucket" {
  bucket = "rss-task-1-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }
  backend "s3" {
    bucket         	   = "rss-task-1-bucket"
    key                = "state/terraform.tfstate"
    region         	   = "eu-central-1"
    encrypt        	   = true
  }
 }