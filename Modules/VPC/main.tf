#Create the vpc
resource "aws_vpc" "projectVPC" {
  cidr_block = var.vpc_cidr
}

#Create 2 public subnets split across AZs
resource "aws_subnet" "pubsub1" {
  vpc_id = aws_vpc.projectVPC.id
  count = 2
  cidr_block = 
}


resource "aws_subnet" "pubsub2" {
  vpc_id = aws_vpc.projectVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
}

#Create 2 private subnets split across AZs
