terraform {
  backend "s3" {
    bucket  = "rss-task-1-bucket"
    key     = "state/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}