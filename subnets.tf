# subnet 1

resource "aws_subnet" "terraform-subnet1" {
  vpc_id                  =  aws_vpc.alt-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "terra-public-subnet1"
  }
}
 # subnet 2

resource "aws_subnet" "terraform-subnet2" {
  vpc_id                  =  aws_vpc.alt-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "terra-public-subnet2"
  }
}

resource "aws_subnet" "terraform-subnet3" {
  vpc_id                  = aws_vpc.alt-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "terra-public-subnet3"
  }
}