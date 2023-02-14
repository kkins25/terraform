#lauch a VPC
#vpc.tf

resource "aws_vpc" "alt-vpc" {
  cidr_block            = "10.0.0.0/16"
  enable_dns_hostnames  = true
  tags = {
    Name                = "alt-vpc"
  }
}





#create internet gateway
resource "aws_internet_gateway" "alt-int-gateway" {
  vpc_id = aws_vpc.alt-vpc.id

  tags = {
    Name = "alt-vpc-IGW"
  }
}

#route table

resource "aws_route_table" "alt-route_table" {
  vpc_id = aws_vpc.alt-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.alt-int-gateway.id
  }

  tags = {
    Name = "alt-RT"
  }
}
#create subnet




# Associate public subnet 1 with route table

resource "aws_route_table_association" "Altschool-public-subnet1-association" {
  subnet_id      = aws_subnet.terraform-subnet1.id
  route_table_id = aws_route_table.alt-route_table.id
}

# Associate public subnet 2 with public route table

resource "aws_route_table_association" "Altschool-public-subnet2-association" {
  subnet_id      = aws_subnet.terraform-subnet2.id
  route_table_id = aws_route_table.alt-route_table.id
}

# Associate public subnet 3 with public route table

resource "aws_route_table_association" "Altschool-public-subnet3-association" {
  subnet_id      = aws_subnet.terraform-subnet3.id
  route_table_id = aws_route_table.alt-route_table.id
}