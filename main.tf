module "network" {
  source = "./network"
  vpc_cidr = var.vpc_cidr
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  owners = ["137112412989"] # Amazon
}

resource "aws_key_pair" "deployer" {
  key_name   = "my-key"
  public_key = file("${path.module}/my-key.pub")
}

resource "aws_instance" "nginx" {
  #ami                        = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  subnet_id                   = module.network.public_subnet_id
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = ["${aws_security_group.allow_ports.id}"]
  user_data                   = file("scripts/install_nginx.sh")

  tags = {
    Name = "nginx-server"
  }
}
