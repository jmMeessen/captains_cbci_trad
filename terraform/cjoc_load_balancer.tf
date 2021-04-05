//Define and configure a load balancer pointing to the CJOC machine 
//and update the DNS record


resource "aws_lb" "cjoc-lb" {

  load_balancer_type = "network"
  subnets            = [aws_subnet.public_subnet.id]

  tags = {
    Name       = "Jmm LoadBalancer 1 (CJOC)"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

variable "ports" {
  type = map(number)
  default = {
    http  = 80
    https = 443
  }
}

resource "aws_lb_listener" "lb1-listener" {

  load_balancer_arn = aws_lb.cjoc-lb.arn

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
    aws_lb.cjoc-lb
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "target_group-attachment" {

  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.cjoc.private_ip
  port             = 8080
}


output "load_balancer_dns" {
  value = aws_lb.cjoc-lb.dns_name
}


//Point CJOC.the-captains-shack.com to the load balancer
resource "ovh_domain_zone_record" "cjoc" {
  zone      = var.domain_name
  subdomain = var.subdomain
  fieldtype = "CNAME"
  ttl       = "30"
  target    = "${aws_lb.cjoc-lb.dns_name}."
}