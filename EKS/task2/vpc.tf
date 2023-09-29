resource "aws_vpc" "rattle_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "rattle-vpc"
  }
}

resource "aws_internet_gateway" "rattle_igw" {
  vpc_id = aws_vpc.rattle_vpc.id
}

variable "azs" {
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.rattle_vpc.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${var.azs[count.index]}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.rattle_vpc.id
  cidr_block        = "10.0.${count.index + 10}.0/24"
  availability_zone = var.azs[count.index]
  tags = {
    Name = "private-subnet-${var.azs[count.index]}"
  }
}

resource "aws_route_table" "public_route_table" {
  count = length(aws_subnet.public_subnets)

  vpc_id = aws_vpc.rattle_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rattle_igw.id
  }

  tags = {
    Name = "public-route-table-${element(aws_subnet.public_subnets.*.id, count.index)}"
  }
}


resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table[count.index].id
}

