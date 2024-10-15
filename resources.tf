# resource "aws_s3_bucket" "rss-task-2-bucket" {
#   bucket = "rss-task-2-bucket"
#   acl    = "private"
# }

# resource "aws_s3_bucket_versioning" "rss-task-2-bucket-versioning" {
#   bucket = aws_s3_bucket.rss-task-2-bucket.bucket
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# VPC
resource "aws_vpc" "terraform-lab-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-lab-vpc"
  }
}

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

# Public subnetss
resource "aws_subnet" "public-subnet-1" { 
  tags = {
    Name = "public-terraform-lab-subnet-1"
  }
  cidr_block        = var.public_subnet_1_cidr
  vpc_id            = aws_vpc.terraform-lab-vpc.id
  availability_zone = var.availability_zones[0]
}
variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}

resource "aws_subnet" "public-subnet-2" { 
  tags = {
    Name = "public-terraform-lab-subnet-2"
  }
  cidr_block        = var.public_subnet_2_cidr
  vpc_id            = aws_vpc.terraform-lab-vpc.id
  availability_zone = var.availability_zones[1]
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}

# Private subnets
resource "aws_subnet" "private-subnet-1" {
  tags = {
    Name = "private-terraform-lab-subnet-1"
  }
  cidr_block        = var.private_subnet_1_cidr
  vpc_id            = aws_vpc.terraform-lab-vpc.id
  availability_zone = var.availability_zones[0]
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
resource "aws_subnet" "private-subnet-2" {
  tags = {
    Name = "private-terraform-lab-subnet-2"
  }
  cidr_block        = var.private_subnet_2_cidr
  vpc_id            = aws_vpc.terraform-lab-vpc.id
  availability_zone = var.availability_zones[1]
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.4.0/24"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}
