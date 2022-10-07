#Create an ALB with target group and listeners
resource "aws_lb" "projectLB" {
  name               = "projectLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.albsecurity.id]
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

resource "aws_lb_target_group_attachment" "projectattach1" {
  target_group_arn = aws_lb_target_group.projectTARGETgroup.arn
  target_id        = var.instanceid1
  port             = 80
}

resource "aws_lb_target_group_attachment" "projectattach2" {
  target_group_arn = aws_lb_target_group.projectTARGETgroup.arn
  target_id        = var.instanceid2
  port             = 80
}

#ALB security group
resource "aws_security_group" "albsecurity" {
  name        = "albsecurity"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}