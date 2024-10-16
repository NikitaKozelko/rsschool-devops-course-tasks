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

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "terraform-lab-igw" {
  tags = {
    Name = "terraform-lab-igw"
  }
  vpc_id = aws_vpc.terraform-lab-vpc.id
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.terraform-lab-vpc.id
  tags = {
    Name = "public-terraform-lab-route-table"
  }
}

resource "aws_route" "public-internet-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.terraform-lab-igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Associate the newly created route tables to the subnets
resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}
resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}

# Security group for EC2
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.terraform-lab-vpc.id

  # Allow ssh access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # from everywhere
  }

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # from everywhere
  }

  # Allow all out traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-security-group"
  }
}

# find lighweith AMI "AWS Amazon Linux 2"
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Create ec2 instance
resource "aws_instance" "ec2_public_instance" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public-subnet-1.id

  associate_public_ip_address = true

  security_groups = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = "public-ec2-instance"
  }
}