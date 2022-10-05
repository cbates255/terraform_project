
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