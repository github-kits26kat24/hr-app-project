resource "aws_internet_gateway" "hr-app-gw" {
  vpc_id = aws_vpc.hr-app.id

  tags = {
    Name = "main-hr-app"
  }
}