module "vpc" {
  source = "./modules/vpc"
  name = var.project_name
  availability_zones = var.availability_zones
  public_subnet_cidr_blocks = var.public_cidr_blocks
  private_subnet_cidr_blocks = var.private_cidr_blocks
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "lighting_db" {
  source = "./modules/dynamo"
  db_name = "lighting"
  hash_key = "id"
  hash_key_type = "N"
}

module "heating_db" {
  source = "./modules/dynamo"
  db_name = "heating"
  hash_key = "id"
  hash_key_type = "N"
}

module "instances" {
  source = "./modules/servers"
  public_subnet_ids = module.vpc.public_subnets[*].id
  private_subnet_ids = module.vpc.private_subnets[*].id
  security_groups = [module.security.security_group_ingress_id, module.security.security_group_egress_id]
  key_name = var.key_name
}