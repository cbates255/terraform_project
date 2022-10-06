output "instanceid1" {
  value = aws_instance.projectec2[0].id
}

output "instanceid2" {
  value = aws_instance.projectec2[1].id
}