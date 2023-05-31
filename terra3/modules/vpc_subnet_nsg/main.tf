


resource "aws_vpc" "main" {
 cidr_block = var.vpc_cidr_block
}



resource "aws_subnet" "main" {
 vpc_id = aws_vpc.main.id
 cidr_block = var.subnet_cidr_block
 availability_zone = "ap-south-1a" # Change to your desired availability zone
}







resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "my_igw"
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
   tags = {
      Name = "my_route_table"
   }
}
resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.route_table.id
}









resource "aws_security_group" "main" {
 name = var.security_group_name
 description = "Security group for the VPC"
 vpc_id = aws_vpc.main.id


  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

 # Additional configuration for the security group rules
}
