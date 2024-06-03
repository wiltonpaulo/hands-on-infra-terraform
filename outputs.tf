output "vpc_id" {
  value = module.network.vpc_id
}

output "subnet_id" {
  value = module.network.public_subnet_id
}

output "instance_public_ip" {
  value = aws_instance.nginx.public_ip
}
