resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "rs-task3-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rs-task3-igw"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    "Name" = "Elastic IP task3"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.bastion_subnet.id

  tags = {
    Name = "rs-task3-nat-gateway"
  }
}

# EIP
resource "aws_eip" "bastion_eip" {
  domain = "vpc"
  tags = {
    "Name" = "Elastic IP task3"
  }
}
## associating the EIP for our Bastion host
resource "aws_eip_association" "ec2-bastion-host-eip-association" {
    instance_id = aws_instance.bastion.id
    allocation_id = aws_eip.bastion_eip.id
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw.id
}

resource "aws_subnet" "bastion_subnet" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "rs-task3-public-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_master" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "rs-task3-private-subnet-a"
  }
}

resource "aws_subnet" "private_subnet_worker" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "rs-task3-private-subnet-b"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rs-task3-public-route-table"
  }
}

resource "aws_route_table_association" "public_bastion" {
  subnet_id      = aws_subnet.bastion_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rs-task3-private-route-table"
  }
}

resource "aws_route_table_association" "private_master" {
  subnet_id      = aws_subnet.private_subnet_master.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_worker" {
  subnet_id      = aws_subnet.private_subnet_worker.id
  route_table_id = aws_route_table.private_rt.id
}