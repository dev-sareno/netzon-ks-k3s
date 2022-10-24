// VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"

  name = "k3s-vpc"
  cidr = "10.0.0.0/16"

  enable_dns_hostnames = true

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.100.0/24"]
}

// Security group
resource "aws_security_group" "allow_all" {
  name        = "allow-all"
  description = "Allow all traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow all inbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all"
  }
}

// Keypair (SSH) for EC2
resource "aws_key_pair" "k3s_keypair" {
  key_name   = "k3s-keypair"
  public_key = base64decode(var.ssh_public_key_base64)
}

// Fetch AMI; Amazon Linux 2
data "aws_ami" "amazon_linux_2" {
 most_recent = true

 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }

 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

// EC2
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "k3s-ec2"

  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.k3s_keypair.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Name = "k3s-ec2"
  }
}
