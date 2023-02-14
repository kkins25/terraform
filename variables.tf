#variables associated with EC2
variable "region" {
  description = "AWS region"
  type = string
  default = "us-east-1"
}

variable "access_key" {
    description = "access key"
    type = string
}
variable "secret_key" {
    description = "secret key"
    type = string
    
}


variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instances"
  default = "ami-0aa7d40eeae50c9a9"
}


variable "domain_names" {
  description = "Describes the domain and subdomain names"
  type = map(string)
}

