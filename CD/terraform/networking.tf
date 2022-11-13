data "aws_availability_zones" "zones" {}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.stack}-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = var.az_numbers
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.zones.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.stack}-public-subnet${count.index + 1}"
  }
}

resource "aws_subnet" "private" {
  count             = var.az_numbers
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.zones.names[count.index]
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_numbers + count.index)

  tags = {
    Name = "${var.stack}-private-subnet${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.stack}-igw"
  }
}

resource "aws_eip" "eip" {
  count      = var.az_numbers
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.stack}-eip${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = var.az_numbers
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.eip.*.id, count.index)

  tags = {
    Name = "${var.stack}-nat${count.index + 1}"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private_route_table" {
  count  = var.az_numbers
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }

  tags = {
    Name = "${var.stack}-private_route_table${count.index + 1}"
  }
}
resource "aws_route_table_association" "route_association" {
  count          = var.az_numbers
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}
