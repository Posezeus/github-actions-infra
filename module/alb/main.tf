resource "aws_lb" "demo-alb" {
  name               = "${var.project-name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb-sg-id]
  subnets            = var.public-subnets-ids

  tags = {
    Name = "${var.project-name}-alb"
  }
}
resource "aws_lb_target_group" "demo-target-group" {
  health_check {
    interval            = 10
    path                = "/index.html"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  name        = "${var.project-name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc-id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.demo-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo-target-group.arn
  }
}


