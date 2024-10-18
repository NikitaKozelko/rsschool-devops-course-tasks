resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.terraform-lab-vpc.id

  tags = {
    Name = "public-nacl"
  }
}

# Allow all Ingress Traffic (from everywhere, for all protocols)
resource "aws_network_acl_rule" "allow_all_ingress" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100  # Rule number must be unique per rule
  egress         = false
  protocol       = "-1" # -1 means all protocols
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow from all IPs

  # Define port range to allow all ports
  from_port = 0
  to_port   = 65535
}

# Allow all Egress Traffic (to everywhere, for all protocols)
resource "aws_network_acl_rule" "allow_all_egress" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 200
  egress         = true
  protocol       = "-1" # -1 means all protocols
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0" # Allow to all IPs

  # Define port range to allow all ports
  from_port = 0
  to_port   = 65535
}

# Step 4: Associate the NACL with Public Subnets
resource "aws_network_acl_association" "public_subnet_1_nacl_association" {
  subnet_id      = aws_subnet.public-subnet-1.id
  network_acl_id = aws_network_acl.public_nacl.id
}

resource "aws_network_acl_association" "public_subnet_2_nacl_association" {
  subnet_id      = aws_subnet.public-subnet-2.id
  network_acl_id = aws_network_acl.public_nacl.id
}