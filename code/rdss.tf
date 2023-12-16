# create the subnet group for the rds instance
resource "aws_db_subnet_group" "hr-app_subnet_group" {
  name        = "hr-app-database_subnets"
  subnet_ids  = [aws_subnet.Node-One.id, aws_subnet.Node-Two.id, aws_subnet.Monitoring-Machine.id]
  description = "subnet for database instance"
  tags = {
    Name = "hr-app-database_subnets"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# resource "aws_db_parameter_group" "hr-app-pg" {
#   name   = "hr-app-parameter"
#   family = "postgres15"

#   parameter {
#     name  = "max_allowed_packet"
#     value = "16777216"
#   }
# }

# create the rds instance
resource "aws_db_instance" "hr-app-db_instance" {
  engine                 = "postgres"
  engine_version         = "15.3"
  multi_az               = false
  identifier             = "project"
  username               = "kitskatrds"
  password               = "kitskat2023"
  instance_class         = "db.t3.micro"
  allocated_storage      = 400
  # parameter_group_name   = aws_db_parameter_group.hr-app-pg.name
  db_subnet_group_name   = aws_db_subnet_group.hr-app_subnet_group.id
  vpc_security_group_ids = [aws_security_group.hr-app-sg.id]
  availability_zone      = data.aws_availability_zones.available_zones.names[0]
  db_name                = "mydatabase"
  publicly_accessible    = false
  skip_final_snapshot    = false
}