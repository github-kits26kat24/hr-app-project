output "ec2_dev_public_ip" {
  value = var.env == "dev" ? aws_instance.Node-One.public_ip : "not required"
}

output "ec2_dev_public_ip_1" {
  value = var.env == "dev" ? aws_instance.Node-Two.public_ip : "not required"
}

# output "ec2_sit_public_ip_2" {
#   value = var.env == "sit" ? aws_instance.Legal_Node.public_ip : "not required"
# }