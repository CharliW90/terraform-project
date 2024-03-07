project_name = "terraform-project"
availability_zones = [ "eu-west-2a", "eu-west-2b", "eu-west-2c" ]
vpc_cidr_block = "10.0.0.0/16"
public_cidr_blocks = [ "10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24" ]
private_cidr_blocks = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
key_name = "project-key"

lighting_ami = "ami-01d1b4f3b7868a9a1"
heating_ami = "ami-0b94d8d1034624e9d"
auth_ami = "ami-0b136ecd29b3c78a3"
status_ami = "ami-0e723336e3bd32541"  #needs updating regularly