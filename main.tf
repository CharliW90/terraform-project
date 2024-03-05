module "vpc" {
  source = "./modules/vpc"
  name = var.project_name
  availability_zones = var.availability_zones
  vpc_cidr_block = var.vpc_cidr_block
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
  public_security_groups = [module.security.security_group_ingress_id, module.security.security_group_egress_id, module.security.security_group_ssh_in_id, module.security.security_group_internal_port]
  private_security_groups = [module.security.security_group_egress_id, module.security.security_group_ssh_in_id, module.security.security_group_internal_port]
  key_name = var.key_name
}

module "external_load_balancer" {
  depends_on = [ module.instances ]
  source = "./modules/load-balancers"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  public = true
  target_port = 3000
  target_protocol = "HTTP"
  target_protocol_version = "HTTP1"
  security_groups = [module.security.security_group_ingress_id, module.security.security_group_egress_id]
  subnets = module.vpc.public_subnets[*].id
  listen_port = 80
  listen_protocol = "HTTP"
  instances = [
    {id=module.instances.lighting_id,public=true,api_path="lights"},
    {id=module.instances.heating_id,public=true,api_path="heating"},
    {id=module.instances.status_id,public=true,api_path="status"}
    ]
}

module "internal_load_balancer" {
  depends_on = [ module.instances ]
  source = "./modules/load-balancers"
  project_name = var.project_name
  vpc_id = module.vpc.vpc_id
  public = false
  target_port = 3000
  target_protocol = "HTTP"
  target_protocol_version = "HTTP1"
  security_groups = [module.security.security_group_egress_id, module.security.security_group_internal_port]
  subnets = module.vpc.private_subnets[*].id
  listen_port = 80
  listen_protocol = "HTTP"
  instances = [{id="${module.instances.auth_id}",public=false,api_path="auth"}]
}