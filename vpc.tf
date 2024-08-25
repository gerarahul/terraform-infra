module "prod_vpc" {
  source = "./modules/vpc"

  vpc_cidr                   = "10.0.0.0/16"
  public_subnets_cidr        = ["10.0.0.0/20", "10.0.16.0/20"]
  private_subnets_cidr       = ["10.0.144.0/20", "10.0.128.0/20"]
  region                     = "ap-southeast-1"
  availability_zones_public  = ["ap-southeast-1a", "ap-southeast-1b"]
  availability_zones_private = ["ap-southeast-1b", "ap-southeast-1a"]
  project                    = "test"
  create_eip_for_natgw       = true
  tags = {
    "env" = "prod"
  }
}
