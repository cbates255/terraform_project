

module "VPC" {
  source            = "./Modules/VPC"
  vpc_cidr          = "10.0.0.0/16"
  pubsubCIDRblocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  privsubCIDRblocks = ["10.0.3.0/24", "10.0.4.0/24"]
  azs               = ["us-east-1a", "us-east-1b"]
}

module "Database" {
  source           = "./Modules/Database"
  count            = 1
  db_name          = "projectDB"
  db_engine        = "mysql"
  db_instanceclass = "db.t3.micro"
  dbuser           = "projectuser"
  dbpass           = "projectpass"
  privsubid        = module.VPC.privsubid
  securitygroup    = module.VPC.securitygroup
  dbstorage        = 10
  vpc_id           = module.VPC.vpcid
  dbsecuritygroup  = module.VPC.dbsecuritygroup
}


module "LoadBalancer" {
  source         = "./Modules/Load Balancer"
  pubsuballid    = module.VPC.pubsuballid
  vpc_id         = module.VPC.vpcid
  listenport     = 80
  listenprotocol = "HTTP"
  instanceid1    = module.Ec2.instanceid1
  instanceid2    = module.Ec2.instanceid2
}

module "Ec2" {
  source        = "./Modules/Ec2"
  pubsubnets    = module.VPC.pubsubnets
  securitygroup = [module.VPC.securitygroup]
  pubsuballid   = module.VPC.pubsuballid
}