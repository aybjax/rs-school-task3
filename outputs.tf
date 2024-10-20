output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnets" {
  value = [
    aws_subnet.private_subnet_master.id,
    aws_subnet.private_subnet_worker.id,
  ]
}

output "public_subnets" {
  value = [
    aws_subnet.bastion_subnet.id,
  ]
}

output "bastion-public-ip" {
  value = aws_eip.bastion_eip.public_ip
}

output "private-ec2-private-ips" {
  value = {
    "subnet_a_ec2" : aws_instance.ec2_master.private_ip,
    "subnet_b_ec2" : aws_instance.ec2_worker.private_ip
  }
}
