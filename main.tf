terraform {
  backend "s3" {
    bucket  = "rss-task-2-bucket"
    key     = "state/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}