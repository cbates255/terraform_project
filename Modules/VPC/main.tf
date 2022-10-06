
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
  vpc_id = aws_vpc.projectVPC.id
}

#VPC security group
resource "aws_security_group" "projectVPCsg" {
  name        = "projectVPCsg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.projectVPC.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#Private DB security group
resource "aws_security_group" "databasesecgroup" {
  name        = "databasesecgroup"
  description = "Inbound from app tier"
  vpc_id      = aws_vpc.projectVPC.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.projectVPCsg.id]
  }
}

#Create public and private subnet route tables
resource "aws_route_table" "publicroute" {
  vpc_id = aws_vpc.projectVPC.id

  route {
    gateway_id = aws_internet_gateway.projectgateway.id
  }
}

resource "aws_route_table" "privateroute" {
  vpc_id = aws_vpc.projectVPC.id

  route {
    gateway_id = aws_internet_gateway.projectgateway.id
  }
}

#Route table associations
resource "aws_route_table_association" "public" {
  count           = length(aws_subnet.pubsub)
  subnet_id       = aws_subnet.pubsub[count.index].id
  route_table_id  = aws_route_table.publicroute.id
}

resource "aws_route_table_association" "private" {
  count           = length(aws_subnet.privsub)
  subnet_id       = aws_subnet.privsub[count.index].id
  route_table_id  = aws_route_table.privateroute.id
}