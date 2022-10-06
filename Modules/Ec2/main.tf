
resource "aws_instance" "projectec2" {
  count = var.pubsubnets
  ami           = var.amazonlinux_ami
  instance_type = "t2.micro"
}