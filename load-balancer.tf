#Load balancer 

resource "aws_alb" "alb" {
  name = "alt-alb"
  internal        = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_to_instances.id]
  subnets         = [
    aws_subnet.terraform-subnet1.id, 
    aws_subnet.terraform-subnet2.id,
    aws_subnet.terraform-subnet3.id
    ]
    depends_on = [aws_instance.terraform-1, 
    aws_instance.terraform-2, 
    aws_instance.terraform-3]
}

#setting target groups
resource "aws_alb_target_group" "target_group" {
  name     = "target"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.alt-vpc.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 30
    timeout             = 5
    path                = "/"
  }
}

#listerner of load balancer
resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
}

# Listener rule

resource "aws_lb_listener_rule" "listener-rule" {
  listener_arn = aws_alb_listener.listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
  condition {
    path_pattern {
      values = ["/"]
    }
  }
}


#linking target group to ELB
# Attach the target group to the load balancer
resource "aws_lb_target_group_attachment" "Altschool-target-group-attachment1" {
  target_group_arn = aws_alb_target_group.target_group.arn
  target_id        = aws_instance.terraform-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "Altschool-target-group-attachment2" {
  target_group_arn = aws_alb_target_group.target_group.arn
  target_id        = aws_instance.terraform-2.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "Altschool-target-group-attachment3" {
   target_group_arn = aws_alb_target_group.target_group.arn
  target_id        = aws_instance.terraform-3.id
  port             = 80
}


