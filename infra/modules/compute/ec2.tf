# Módulo de computo para el servicio de órdenes
# Define instancias EC2, load balancers y auto scaling groups

resource "aws_launch_template" "orders_lt" {
  name_prefix   = "orders-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.orders_ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "orders-instance"
    }
  }
}

resource "aws_autoscaling_group" "orders_asg" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.orders_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "orders-asg"
    propagate_at_launch = true
  }
}

resource "aws_lb" "orders_alb" {
  name               = "orders-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.orders_alb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "orders-alb"
  }
}

resource "aws_lb_target_group" "orders_tg" {
  name     = "orders-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "orders_listener" {
  load_balancer_arn = aws_lb.orders_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders_tg.arn
  }
}

resource "aws_security_group" "orders_ec2_sg" {
  name        = "orders-ec2-sg"
  description = "Security group para instancias EC2 del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.orders_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orders-ec2-sg"
  }
}

resource "aws_security_group" "orders_alb_sg" {
  name        = "orders-alb-sg"
  description = "Security group para el ALB del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orders-alb-sg"
  }
}

# TODO(reto): Configurar auto scaling policies basadas en métricas de CPU
# Implementar políticas de escalado automático para el ASG