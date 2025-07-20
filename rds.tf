resource "aws_db_instance" "mssql" {
  allocated_storage      = 20
  engine                 = "sqlserver-ex"
  engine_version         = "15.00.4043.16.v1"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password

  publicly_accessible    = true  # <--- allow connection from your local machine

  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.sql_subnet_group.name

  # Use sql_sg (which includes your IP)
  vpc_security_group_ids = [aws_security_group.sql_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "PearlFurniture-MSSQL"
  }
}

resource "aws_db_instance" "mssql" {
  allocated_storage      = 20
  engine                 = "sqlserver-ex"
  engine_version         = "15.00.4043.16.v1"
  instance_class         = "db.t3.micro"
  username               = var.db_username
  password               = var.db_password
  publicly_accessible    = false
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.sql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  skip_final_snapshot = true

  tags = {
    Name = "PearlFurniture-MSSQL"
  }
}


