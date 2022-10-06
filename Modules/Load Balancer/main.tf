resource "aws_lb" "projectLB" {
  name               = "projectLB"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.pubsuballid
}

resource "aws_lb_target_group" "projectTARGETgroup" {
  name     = "projectTARGETgroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}