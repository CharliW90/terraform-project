module "vpc" {
  source = "./modules/vpc"
  name = var.project_name
  availability_zones = var.availability_zones
  public_subnet_cidr_blocks = var.public_cidr_blocks
  private_subnet_cidr_blocks = var.private_cidr_blocks
}