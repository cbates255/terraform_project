
resource "aws_instance" "projectec2" {
  count = var.pubsubnets
  ami           = var.amazonlinux_ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = var.securitygroup
  subnet_id = var.pubsuballid[count.index]
}