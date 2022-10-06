output "vpcid" {
  value = aws_vpc.projectVPC.id
}

output "privsubid" {
  value = aws_subnet.privsub[0].id
}

output "pubsuballid" {
  value = aws_subnet.pubsub.id[count.index]
}

output "pubsubnets" {
  value = length(aws_subnet.pubsub)
}

output "instance_azs" {
  value = var.azs
}

output "securitygroup" {
  value = aws_security_group.projectVPCsg.id
}