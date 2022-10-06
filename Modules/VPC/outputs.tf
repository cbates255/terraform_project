output "vpcid" {
  value = aws_vpc.projectVPC.id
}

output "privsubid" {
  value = aws_subnet.privsub[*].id
}

output "pubsuballid" {
  value = aws_subnet.pubsub[*].id
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

output "dbsecuritygroup" {
  value = aws_security_group.databasesecgroup.id
}