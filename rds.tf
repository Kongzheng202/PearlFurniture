# Subnet group using public subnets for external access
resource "aws_db_subnet_group" "sql_subnet_group" {
  name       = "sql-subnet-group"
  subnet_ids = [aws_subnet.public_az1.id, aws_subnet.public_az2.id]

  tags = {
    Name = "SQL Subnet Group"
  }
}

# Security group allowing access from backend EC2 and your IP
resource "aws_security_group" "sql_sg" {
  name        = "sql-sg"
  description = "Allow SQL Server access from backend instances and your IP"
  vpc_id      = aws_vpc.pearlfurniture-vpc.id

  ingress {
    description     = "Allow SQL from backend instances"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }

  ingress {
    description = "Allow SQL from your IP"
    from_port   = 1433
    to_port     = 1433
    protocol    = "tcp"
    cidr_blocks = ["113.211.212.189/32"] # <-- Replace with your actual IP if needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sql-sg"
  }
}

# Microsoft SQL Server RDS Instance
resource "aws_db_instance" "mssql" {
  allocated_storage = 20
  engine            = "sqlserver-ex"
  engine_version    = "15.00.4043.16.v1"
  instance_class    = "db.t3.micro"
  username          = var.db_username
  password          = var.db_password

  publicly_accessible    = true
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.sql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sql_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "PearlFurniture-MSSQL"
  }
}




