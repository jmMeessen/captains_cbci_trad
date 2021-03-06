//Define and configure a load balancer with an eip pointing to the jenkins machine

resource "aws_lb" "loadblancer-1" {

  load_balancer_type = "network"
  #subnets = data.aws_subnet_ids.this.ids
  subnets = [aws_subnet.public_subnet.id]

  tags = {
    Name       = "Jmm LoadBalancer 1"
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

  load_balancer_arn = aws_lb.loadblancer-1.arn

  protocol = "TCP"
  port     = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_lb_target_group" "target_group" {

  port        = 8080
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

  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.jenkins.private_ip
  port             = 8080
}


output "load_balancer_dns" {
  value = aws_lb.loadblancer-1.dns_name
}