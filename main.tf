data "aws_subnet_ids" "ids" {
  vpc_id = module.VPC.vpcid
  tags = {
    "Private" = "True"
  }
}

data "aws_subnet" "id" {
  vpc_id = module.VPC.vpcid
  tags = {
    "Private" = "True"
  }
}

module "VPC" {
  source = "./Modules/VPC"
  vpc_cidr = "10.0.0.0/16"
  pubsubCIDRblocks = ["10.0.1.0/24", "10.0.2.0/24"]
  privsubCIDRblocks = ["10.0.3.0/24", "10.0.4.0/24"]
  azs = ["us-east-1a", "us-east-1b"]
}

module "Database" {
  source = "./Modules/Database"
  count = 1
  db_name = "projectDB"
  db_engine = "mysql"
  db_instanceclass = "t2.micro"
  dbuser = "projectuser"
  dbpass = "projectpass"
  dbsubnetid = tostring(data.aws_subnet.id.id)
}

#dbsubnetid