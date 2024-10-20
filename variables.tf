variable "public-key-path" {
  type = string
  default = "ssh/ec2-bastion.pub"
}
variable "private-key-path" {
  type = string
  default = "ssh/ec2-bastion.pem"
}
variable "key-nam" {
  default = "ec2-bastion"
}

# Optional
variable "ec2_image" {
  type    = string
  default = "ami-0084a47cc718c111a"
}

variable "ec2_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_type_worker" {
  type    = string
  default = "t3.medium"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "availability_zone_a" {
  type    = string
  default = "eu-central-1a"
}

variable "availability_zone_b" {
  type    = string
  default = "eu-central-1b"
}