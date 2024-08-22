
resource "aws_alb" "alb" {
  name            = "cpaor-streamlit-lb-${var.environment}"
  subnets         = var.public_subnets
  security_groups = [aws_security_group.alb_sg.id]
}

resource "aws_alb_target_group" "tg" {
  name        = "alb-target-group-${var.environment}"
  port        = var.app_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    port                = var.app_port
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 30
    protocol            = "HTTP"
    matcher             = "200,301,302"
    path                = var.health_check_path
    interval            = 60
  }
}

data "aws_acm_certificate" "data_cpaor" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}


# Redirecting all incomming traffic from ALB to the target group
resource "aws_alb_listener" "app_listener" {
  load_balancer_arn = aws_alb.alb.id
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.data_cpaor.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }
}
