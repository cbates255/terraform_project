
resource "aws_instance" "projectec2" {
  count = var.pubsubnets
  ami           = var.amazonlinux_ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  security_groups = var.securitygroup
  availability_zone = var.instance_azs
  subnet_id = var.pubsuballid
}