# Lookup latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Web/API Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP, HTTPS, SSH"
  vpc_id      = aws_vpc.pearlfurniture-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# Backend Security Group
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Allow MySQL from Web/API, allow all egress"
  vpc_id      = aws_vpc.pearlfurniture-vpc.id

  ingress {
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "backend-sg"
  }
}

# Web/API EC2 - AZ1
resource "aws_instance" "web_az1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_az1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "pearlfurniture"

  tags = {
    Name = "web-az1"
  }
}

# Web/API EC2 - AZ2
resource "aws_instance" "web_az2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_az2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "pearlfurniture"

  tags = {
    Name = "web-az2"
  }
}

# Backend EC2 - AZ1 
resource "aws_instance" "backend-az1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_az1.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = "pearlfurniture"

  tags = {
    Name = "pearlfurniture-ec2"
  }
}

# Backend EC2 - AZ2
resource "aws_instance" "backend_az2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_az2.id
  vpc_security_group_ids = [aws_security_group.backend_sg.id]
  key_name               = "pearlfurniture"

  tags = {
    Name = "backend-az2"
  }
}
