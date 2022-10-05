module "VPC" {
  source = "./Modules/VPC"
  vpc_cidr = "10.0.0.0/16"
  pubsubCIDRblocks = ["10.0.1.0/24", "10.0.2.0/24"]
  privsubCIDRblocks = ["10.0.3.0/24", "10.0.4.0/24"]
  azs = ["us-east-1a", "us-east-1b"]
}

