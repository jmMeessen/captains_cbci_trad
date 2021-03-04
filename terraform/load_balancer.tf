//Define and configure a load balancer with an eip pointing to the jenkins machine

resource "aws_lb" "loadblancer-1" {

  load_balancer_type = "network"
  #subnets = data.aws_subnet_ids.this.ids
  subnets = aws_subnet.public_subnet.id

  tags = {
    Name       = "Jmm's LoadBalancer #1"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }

  # subnet_mapping {
  #   subnet_id            = aws_subnet.example1.id
  #   private_ipv4_address = "10.0.1.15"
  # }

  # subnet_mapping {
  #   subnet_id            = aws_subnet.example2.id
  #   private_ipv4_address = "10.0.2.15"
  # }
}

variable "ports" {
  type = map(number)
  default = {
    http  = 80
    https = 443
  }
}

resource "aws_lb_listener" "lb1-listener" {
  for_each = var.ports

  load_balancer_arn = aws_lb.loadblancer-1.arn

  protocol = "TCP"
  port     = each.value

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group[each.key].arn
  }
}

resource "aws_lb_target_group" "target_group" {
  for_each = var.ports

  port        = each.value
  protocol    = "TCP"
  vpc_id      = aws_vpc.jmm-aws-vpc.id
  target_type = "ip"

  depends_on = [
    aws_lb.loadblancer-1
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "target_group-attachment" {
  for_each = var.ports

  target_group_arn  = aws_lb_target_group.target_group[each.value].arn
  target_id         = aws_instance.jenkins.private_ip
  availability_zone = "all"
  port              = each.value
}


