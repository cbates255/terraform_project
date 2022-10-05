output "vpcid" {
  value = aws_vpc.projectVPC.id
}

output "privsubid" {
  value = aws_subnet.privsub.id
}