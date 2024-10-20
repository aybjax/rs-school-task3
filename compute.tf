resource "aws_instance" "bastion" {
  ami                    = var.ec2_image
  instance_type          = var.ec2_type
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]
  subnet_id              = aws_subnet.bastion_subnet.id
  key_name               = aws_key_pair.key-pair.key_name 

  associate_public_ip_address = false
  tags = {
    "Name" = "Bastion task3"
  }
}

resource "aws_instance" "ec2_master" {
  ami                    = var.ec2_image
  instance_type          = var.ec2_type_worker
  vpc_security_group_ids = [aws_security_group.sg_master.id]
  subnet_id              = aws_subnet.private_subnet_master.id
  key_name               = aws_key_pair.key-pair.key_name 
  tags = {
    "Name" = "Master task3"
  }
}

resource "aws_instance" "ec2_worker" {
  ami                    = var.ec2_image
  instance_type          = var.ec2_type_worker
  vpc_security_group_ids = [aws_security_group.sg_worker.id]
  subnet_id              = aws_subnet.private_subnet_worker.id
  key_name               = aws_key_pair.key-pair.key_name 
  tags = {
    "Name" = "Worker task3"
  }
}
