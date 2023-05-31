variable "vpc_cidr_block" {
 description = "CIDR block for the VPC"
 type = string
}



variable "subnet_cidr_block" {
 description = "CIDR block for the subnet"
 default = ""
}



variable "security_group_name" {
 description = "Name of the security group"
 type  = string
}