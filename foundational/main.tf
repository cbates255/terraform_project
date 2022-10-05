provider "aws" {
  region = "us-east-1"
}

#VPC resource
resource "aws_vpc" "projectVPC" {
  cidr_block = "10.0.0.0/16"
}

#Public subnets resource
resource "aws_subnet" "pubsub1" {
  vpc_id = aws_vpc.projectVPC.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"
}

  #Public subnets resource
resource "aws_subnet" "pubsub2" {
  vpc_id = aws_vpc.projectVPC.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  cidr_block = "10.0.2.0/24"
}

#Private subnets resource
resource "aws_subnet" "privsub1" {
  vpc_id = aws_vpc.projectVPC.id
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  cidr_block = "10.0.3.0/24"
}

#Private subnets resource
resource "aws_subnet" "privsub2" {
  vpc_id = aws_vpc.projectVPC.id
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = false
  cidr_block = "10.0.4.0/24"
}

#Database
resource "aws_db_instance" "DBinstance" {
  db_name              = "projectDB"
  engine               = "mysql"
  instance_class       = "t2.micro"
  username             = "projectuser"
  password             = "projectpass"
  availability_zone    = "us-east-1a"
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.dbsubgroup.name
}

resource "aws_db_subnet_group" "dbsubgroup" {
  subnet_ids = [aws_subnet.privsub1.id]
}

resource "aws_lb" "projectLB" {
  name               = "projectLB"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.pubsub1.id, aws_subnet.pubsub2.id]
}

resource "aws_lb_target_group" "projectTG" {
  name        = "projectTG"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.projectVPC.id
}

resource "aws_instance" "vm1" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.pubsub1.id
}

resource "aws_instance" "vm2" {
  ami           = "ami-026b57f3c383c2eec"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.pubsub2.id
}