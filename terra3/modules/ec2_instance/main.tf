resource "aws_instance" "k8s_master" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = "jenkins-master"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]

  provisioner "local-exec" {
    command = "sleep 30"
  }

  tags = {
    Name = "k8s_master"
  }
}

output "ec2_instance_id" {
  value = aws_instance.k8s_master.id
}

resource "aws_instance" "k8s_node1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = "jenkins-master"
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.security_group_id]

  provisioner "local-exec" {
    command = "sleep 30"
  }

  tags = {
    Name = "k8s_node1"
  }
}

resource "null_resource" "inventory_creation" {
  depends_on = [
    aws_instance.k8s_master,
    aws_instance.k8s_node1
  ]
  
  provisioner "local-exec" {
    command = <<EOT
      sudo sh -c 'cat <<EOF > /etc/ansible/hosts
      [k8s_master]
      ${aws_instance.k8s_master.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/jenkins-master.pem ansible_ssh_extra_args="-o StrictHostKeyChecking=accept-new"

      [k8s_node1]
      ${aws_instance.k8s_node1.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/jenkins-master.pem ansible_ssh_extra_args="-o StrictHostKeyChecking=accept-new"
    
EOF'
    EOT
  }
}

