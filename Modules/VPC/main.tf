
#VPC resource
resource "aws_vpc" "projectVPC" {
  cidr_block = var.vpc_cidr
}

#Public subnets resource
resource "aws_subnet" "pubsub" {
  vpc_id = aws_vpc.projectVPC.id
  count = length(var.azs)
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  cidr_block = var.pubsubCIDRblocks[count.index]
}

#Private subnets resource
resource "aws_subnet" "privsub" {
  vpc_id = aws_vpc.projectVPC.id
  count = length(var.azs)
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = false
  cidr_block = var.privsubCIDRblocks[count.index]
  tags = {
    "Private" = "True"
  }
}

#Internet gateway
resource "aws_internet_gateway" "projectgateway" {
  vpc_id = aws_vpc.projectVPC
}

#VPC security group
resource "aws_security_group" "projectVPCsg" {
  name        = "projectVPCsg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.projectVPC.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "ssh"
    cidr_blocks      = [aws_vpc.projectVPC.cidr_blocks]
  }
  
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.projectVPC.cidr_blocks]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.projectVPC.cidr_blocks]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}