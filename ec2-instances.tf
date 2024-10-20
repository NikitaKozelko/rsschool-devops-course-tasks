resource "aws_key_pair" "EC2-instance_key" {
  key_name = "K8s-EC2-ssh-key"
  # public_key = file("${path.module}/my-aws-key.pub")
  public_key = var.ssh_public_key
}

resource "aws_instance" "ec2_private_instance-subnet-1" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.private-subnet-1.id

  associate_public_ip_address = true

  key_name      = aws_key_pair.EC2-instance_key.key_name
  security_groups = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = "private-ec2-instance"
  }
}

resource "aws_instance" "ec2_private_instance-subnet-2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.private-subnet-2.id

  associate_public_ip_address = true

  key_name      = aws_key_pair.EC2-instance_key.key_name
  security_groups = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = "private-ec2-instance"
  }
}