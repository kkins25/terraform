# create network acl

resource "aws_network_acl" "Altschool-network_acl" {
  vpc_id     = aws_vpc.alt-vpc.id
  subnet_ids = [aws_subnet.terraform-subnet1.id, aws_subnet.terraform-subnet2.id, aws_subnet.terraform-subnet3.id]
  ingress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  egress {
    rule_no    = 100
    protocol   = "-1"
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
