resource "aws_eip" "nat_gateway" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.terraform-lab-igw]
}

resource "aws_nat_gateway" "terraform-lab-ngw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "terraform-lab-ngw"
  }
  depends_on = [aws_eip.nat_gateway]
}
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.terraform-lab-vpc.id
  tags = {
    Name = "private-terraform-lab-route-table"
  }
}

resource "aws_route" "nat-ngw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.terraform-lab-ngw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private-route-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}
resource "aws_route_table_association" "private-route-2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-2.id
}