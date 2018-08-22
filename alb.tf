resource "aws_lb_target_group" "lb_tg_dmz" {
  name = "lb_tg_dmz"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.vpc_prod.id}"

  health_check {
    interval = "30"
    path = "/"
    port = 80
    protocol = "HTTP"
    healthy_threshold = "2"
    unhealthy_threshold = "5"
    timeout = "20"
    matcher = "200"
  }
}


resource "aws_lb" "lb_dmz" {
  name = "lb-dmz"
  internal = false
  load_balancer_type = "application"
  security_groups = ["${aws_security_group.lb_sg.id}"]
  subnets = ["${aws_subnet.public.*.id}"]

  enable_deletion_protection = false

  tags {
    Environment = "production"
  }
}


resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = "${aws_lb.lb_dmz.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.lb_tg_dmz.arn}"
    type             = "forward"
  }
}


resource "aws_lb_listener" "lb_listener_https" {
  load_balancer_arn = "${aws_lb.lb_dmz.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    target_group_arn = "${aws_lb_target_group.lb_tg_dmz.arn}"
    type             = "forward"
  }
}