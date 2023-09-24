resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "demo-vpc"
  }
}

// VPC Subnet allocated Address space = 10.0.0.0/18
// Subnets allocated address space = 10.0.0.0/21
// possible subnets: 2^21-16 = 2^5 = 32
//  subnet 1 usable address space: 10.0.0.3/21 - 10.0.7.254/21
//  subnet 2 usable address space: 10.0.8.3/21 - 10.0.15.254/21
//  ...
// possible IPs:     2^(32-21)-5 = (2^11)-5 = 2048-5 = 2043

resource "aws_subnet" "demo_subnet_1a" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.0.0/21"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Demo Subnet 1a"
  }
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id

  tags = {
    Name = "Demo Internet Gateway"
  }
}

resource "aws_route_table" "rt_subnet_1a" {
  vpc_id = aws_vpc.demo_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

  tags = {
    Name = "Demo Route Table 1a"
  }
}

resource "aws_route_table_association" "rta_subnet_1a" {
  subnet_id      = aws_subnet.demo_subnet_1a.id
  route_table_id = aws_route_table.rt_subnet_1a.id
}

