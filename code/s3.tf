terraform {
  backend "s3" {
    bucket         = "hr-app-project-bucket"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "mydatabase"
  }
}
