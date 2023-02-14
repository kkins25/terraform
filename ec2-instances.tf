
# creating instances 1
resource "aws_instance" "terraform-1" {
  ami             = var.ami_id 
  instance_type   = "t2.micro"
  key_name        = "terraform"
  security_groups = [aws_security_group.allow_web.id]
  subnet_id       = aws_subnet.terraform-subnet1.id
  availability_zone = "us-east-1a"

 
  tags = {
    Name   = "terra-server-1"
  }
  
}
# creating instance 2
 resource "aws_instance" "terraform-2" {
  ami             = var.ami_id 
  instance_type   = "t2.micro"
  key_name        = "terraform"
  security_groups = [aws_security_group.allow_web.id]
  subnet_id       = aws_subnet.terraform-subnet2.id
  availability_zone = "us-east-1b"
  tags = {
     Name   = "terra-server-2"
  }
}
# creating instance 3
resource "aws_instance" "terraform-3" {
  ami             = var.ami_id 
  instance_type   = "t2.micro"
  key_name        = "terraform"
  security_groups = [aws_security_group.allow_web.id]
  subnet_id       = aws_subnet.terraform-subnet3.id
  availability_zone = "us-east-1c"
  tags = {
     Name   = "terra-server-3"
  }
}
# crewte a file to store the IP addresses of the instances
resource "local_file" "Ip_address" {
  filename = "./host-inventory"
  content  = <<EOT
${aws_instance.terraform-1.public_ip}
${aws_instance.terraform-2.public_ip }
${aws_instance.terraform-3.public_ip}
  EOT                 
}

#move host-inventory to instance 1


 resource "null_resource" "ansiblecfg" {

  provisioner "file" {
    source      = "C:/Users/kingsley/Terraform/ansible.cfg"
    destination = "/home/ec2-user/ansible.cfg"
  }

  connection {
    host     = "${aws_instance.terraform-1.public_ip}"
    type     = "ssh"
    user     = "ec2-user"
    agent    = "false"
    private_key = "${file("C:/Users/kingsley/Terraform/terraform.pem")}"
  }
  depends_on = [
    aws_instance.terraform-1
  ]
 }

  resource "null_resource" "hostfile" {

  provisioner "file" {
    source      = "C:/Users/kingsley/Terraform/host-inventory"
    destination = "/home/ec2-user/host-inventory"
  }

  connection {
    host     = "${aws_instance.terraform-1.public_ip}"
    type     = "ssh"
    user     = "ec2-user"
    agent    = "false"
    private_key = "${file("C:/Users/kingsley/Terraform/terraform.pem")}"
  }
  depends_on = [
    aws_instance.terraform-1
  ]
}

resource "null_resource" "mainyml" {

  provisioner "file" {
    source      = "C:/Users/kingsley/Terraform/main.yml"
    destination = "/home/ec2-user/main.yml"
  }

  connection {
    host     = "${aws_instance.terraform-1.public_ip}"
    type     = "ssh"
    user     = "ec2-user"
    agent    = "false"
    private_key = "${file("C:/Users/kingsley/Terraform/terraform.pem")}"
  }
  depends_on = [
    aws_instance.terraform-1
  ]
}