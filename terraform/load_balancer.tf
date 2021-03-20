//Define and configure a load balancer pointing to the jenkins machine 
//and update the DNS record


resource "aws_lb" "loadblancer-1" {

  load_balancer_type = "network"
  subnets            = [aws_subnet.public_subnet.id]

  tags = {
    Name       = "Jmm LoadBalancer 1"
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


//Point jenkins.the-captains-shack.com to the load balancer
resource "ovh_domain_zone_record" "jenkins" {
  zone      = var.domain_name
  subdomain = var.subdomain
  fieldtype = "CNAME"
  ttl       = "30"
  target    = "${aws_lb.loadblancer-1.dns_name}."
}