resource "aws_lb" "projectLB" {
  name               = "projectLB"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.pubsuballid
}

resource "aws_lb_target_group" "projectTARGETgroup" {
  name     = "projectTARGETgroup"
  port     = var.listenport
  protocol = var.listenprotocol
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "projectlistener" {
  load_balancer_arn = aws_lb.projectLB.arn
  port              = var.listenport
  protocol          = var.listenprotocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.projectTARGETgroup.arn
  }
}