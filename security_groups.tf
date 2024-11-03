# Bastion
resource "aws_security_group" "sg_bastion" {
  vpc_id = aws_vpc.main.id
  name   = "rs-task3-instance-security-group-bastion"
}

resource "aws_security_group_rule" "allow_ssh_inbound_bastion" {
  type              = "ingress"
  security_group_id = aws_security_group.sg_bastion.id

  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outbound_bastion" {
  type              = "egress"
  security_group_id = aws_security_group.sg_bastion.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "sg_master" {
  vpc_id = aws_vpc.main.id
  name   = "rs-task3-instance-security-group-private-master"
}

resource "aws_security_group" "sg_worker" {
  vpc_id = aws_vpc.main.id
  name   = "rs-task3-instance-security-group-private-worker"
}

resource "aws_security_group_rule" "allow_k3s_api_server_in_master" {
  type              = "ingress"
  security_group_id = aws_security_group.sg_master.id

  from_port                = 6443
  to_port                  = 6443
  protocol                 = "-1"
  source_security_group_id = aws_security_group.sg_worker.id
}

resource "aws_security_group_rule" "allow_kubelet_api_in_worker" {
  type              = "ingress"
  security_group_id = aws_security_group.sg_worker.id

  from_port                = 10250
  to_port                  = 10250
  protocol                 = "-1"
  source_security_group_id = aws_security_group.sg_master.id
}

resource "aws_security_group_rule" "allow_ssh_inbound_private_master" {
  type              = "ingress"
  security_group_id = aws_security_group.sg_master.id

  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_bastion.id
}

resource "aws_security_group_rule" "allow_ssh_inbound_private_worker" {
  type              = "ingress"
  security_group_id = aws_security_group.sg_worker.id

  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_bastion.id
}

resource "aws_security_group_rule" "allow_all_outbound_private_master" {
  type              = "egress"
  security_group_id = aws_security_group.sg_master.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outbound_private_worker" {
  type              = "egress"
  security_group_id = aws_security_group.sg_worker.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}