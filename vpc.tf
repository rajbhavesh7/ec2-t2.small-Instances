resource "aws_vpc" "vpc_task" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink

  tags = {
      Name = var.tags
    }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_task.id

  tags = {
    Name = "internet-gateway-task"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.vpc_task.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_1-task"
  }
}

resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc_task.id

  route {
    cidr_block = "10.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table-task"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.route-public.id
}