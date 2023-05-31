variable "subnet_id" {
 description = "ID of the subnet where EC2 instance will be launched"
 type = string
}



variable "security_group_id" {
 description = "ID of the security group for EC2 instance"
 type = string
}



variable "instance_type" {
 description = "EC2 instance type"
 type = string
}



variable "ami" {
 description = "AMI ID for the EC2 instance"
 type = string
}