resource "aws_vpc" "test" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
        Name = "${var.environment}-vpc"
    }
  
}


resource "aws_internet_gateway" "test_igw" {
    vpc_id = aws_vpc.test.id
    tags = {
        Name = "${var.environment}-igw"
    }
  
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.test.id
    cidr_block = var.public_subnet_cidr[count.index]

    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "${var.environment}-public-${count.index + 1}"
    }

  
}


resource "aws_subnet" "private" {
    count = length(var.private_subnet_cidr)
    vpc_id = aws_vpc.test.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "${var.environment}-private-${count.index + 1}"
    }
 
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.test.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.test_igw.id
    }

    tags = {
        Name = "${var.environment}-public-rt"
    }
  
}


resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidr)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
  
}


resource "aws_eip" "nat_ip" {
    domain = "vpc"

  
}

resource "aws_nat_gateway" "test_nat" {
    allocation_id = aws_eip.nat_ip.id
    subnet_id = aws_subnet.public[0].id
  
}


resource "aws_route_table" "private" {
    vpc_id = aws_vpc.test.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.test_nat.id
    }

    tags = {
        Name = "${var.environment}-public-rt"
    }
  
}


resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidr)
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
  
}



