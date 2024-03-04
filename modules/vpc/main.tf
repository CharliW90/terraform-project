# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns
  tags = {
    Name = "${var.name}"
  }
}

# Have both Public and Private subnets in each of your availability zones
resource "aws_subnet" "public" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  availability_zone = var.availability_zones[count.index]
  cidr_block = var.public_subnet_cidr_blocks[count.index]

  tags = {
    Name = "public-subnet${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.main.id

  availability_zone = var.availability_zones[count.index]
  cidr_block = var.private_subnet_cidr_blocks[count.index]

  tags = {
    Name = "private-subnet${count.index}"
  }
}

# Be able to accept traffic from the internet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "internet-gateway"
  }
}

# Have a NAT Gateway between public and private subnets
resource "aws_eip" "nat_gateway" {
  depends_on = [ aws_internet_gateway.internet_gateway ]
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.allocation_id
  subnet_id = aws_subnet.public[0].id
  tags = {
    Name = "nat-gateway"
  }
}

# Be able to route traffic back out to the internet
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route" "public_internet" {
  route_table_id = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public[*])
  route_table_id = aws_route_table.public_rtb.id
  subnet_id = aws_subnet.public[count.index].id
}

# Be able to route traffic locally
resource "aws_default_route_table" "private_rtb" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route" "private_internet" {
  route_table_id = aws_default_route_table.private_rtb.id
  nat_gateway_id = aws_nat_gateway.nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private[*])
  route_table_id = aws_default_route_table.private_rtb.id
  subnet_id = aws_subnet.private[count.index].id
}
