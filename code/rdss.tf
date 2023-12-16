# create the subnet group for the rds instance
resource "aws_db_subnet_group" "hr-app_subnet_group" {
  name        = "hr-app-database_subnets"
  subnet_ids  = [aws_subnet.Node-One.id, aws_subnet.Node-Two.id, aws_subnet.Monitoring-Machine.id]
  description = "subnet for database instance"
  tags = {
    Name = "hr-app-database_subnets"
  }
}

# use data source to get all available zones in the region
data "aws_availability_zones" "available_zones" {}

# create the rds instance
resource "aws_db_instance" "hr-app-db_instance" {
  engine                 = "postgres"
  engine_version         = "15.3"
  multi_az               = false
  identifier             = "hr-app-project"
  username               = "kitskatrds"
  password               = "kitskat2023"
  instance_class         = "db.t3.micro"
  allocated_storage      = 400
  db_subnet_group_name   = aws_db_subnet_group.hr-app_subnet_group.name
  vpc_security_group_ids = [aws_security_group.hr-app-sg.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
  db_name                = "mydatabase"
  publicly_accessible    = true
  skip_final_snapshot    = true
}

# data.aws_availability_zones.available_zones.names[0]

# terraform apply -var="availability_zones=[\"eu-west-1a\", \"eu-west-1b\", \"eu-west-1c\"]"
