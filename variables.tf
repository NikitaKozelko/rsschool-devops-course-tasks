variable "region" { default = "eu-central-1" }

# lighweith AMI "AWS Amazon Linux 2"
variable "ec2_default_ami" { default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" }

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR Block for Private Subnet 2"
  default     = "10.0.4.0/24"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "ssh_public_key" {
  description = "SSH public key for accessing the EC2 instance"
  type        = string
  sensitive = true
}