resource "aws_db_subnet_group" "sql_subnet_group" {
  name       = "sql-subnet-group"
  subnet_ids = [aws_subnet.private_az1.id, aws_subnet.private_az2.id]

  tags = {
    Name = "SQL Subnet Group"
  }
}

resource "aws_security_group" "sql_sg" {
  name        = "sql-sg"
  description = "Allow SQL Server access from backend instances"
  vpc_id      = aws_vpc.pearlfurniture-vpc.id

  ingress {
    description     = "Allow SQL Server"
    from_port       = 1433
    to_port         = 1433
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
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

resource "aws_db_instance" "mssql" {
  identifier             = "pearlfurniture-sql"
  engine                 = "sqlserver-ex"     # Express Edition (free tier)
  engine_version         = "15.00.4073.23.v1" # Use latest available version if needed
  instance_class         = "db.t3.micro"      # Free tier eligible
  allocated_storage      = 20
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.sql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sql_sg.id]
  multi_az               = false
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "pearlfurniture-mssql"
  }
}
