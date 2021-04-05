//Define and configure a load balancer pointing to the CM1 machine 
//and update the DNS record


resource "aws_lb" "cm1_lb" {

  load_balancer_type = "network"
  subnets            = [aws_subnet.public_subnet.id]

  tags = {
    Name       = "Jmm  CM1 LoadBalancer"
    Owner      = "Jmm"
    "cb:owner" = "user:Jmm"
  }
}

resource "aws_lb_listener" "cm1_listener" {

  load_balancer_arn = aws_lb.cm1_lb.arn

  protocol = "TCP"
  port     = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cm1_target_group.arn
  }
}

resource "aws_lb_target_group" "cm1_target_group" {

  port        = 8080
  protocol    = "TCP"
  vpc_id      = aws_vpc.jmm-aws-vpc.id
  target_type = "ip"

  depends_on = [
    aws_lb.cm1_lb
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment_cm1" {

  target_group_arn = aws_lb_target_group.cm1_target_group.arn
  target_id        = aws_instance.cm1.private_ip
  port             = 8080
}


output "cm1_load_balancer_dns" {
  value = aws_lb.cm1_lb.dns_name
}


//Point cm1.the-captains-shack.com to the load balancer
resource "ovh_domain_zone_record" "cm1" {
  zone      = var.domain_name
  subdomain = var.cm1_subdomain
  fieldtype = "CNAME"
  ttl       = "30"
  target    = "${aws_lb.cm1_lb.dns_name}."
}