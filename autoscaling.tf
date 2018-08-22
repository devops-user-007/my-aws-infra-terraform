variable AMIID {
    default = "ami-1234"
}

variable USER_DATA_FILE {
    default = "/opt/scripts/ec2_asg_userdata.sh"
}

resource "aws_launch_configuration" "lc_asg_app" {
  name          = "lc_asg_app"
  image_id      = "${ var.AMIID }"
  instance_type = "t2.micro"
  key_name = "ec2key"
  security_groups = [ "${aws_security_group.sg_allow_ssh.id}" ]
  user_data = "${ file("${ var.USER_DATA_FILE }") }"
}





resource "aws_autoscaling_group" "asg_app" {
  name                      = "asg_app"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  launch_configuration      = "${ aws_launch_configuration.lc_asg_app.name }"
  target_group_arns = [ "${ aws_target_group.tg_lb_dmz.arn }" ]
  termination_policies = [ "OldestInstance" ]
  vpc_zone_identifier       = ["${ aws_subnet.public_subnet_1.id}", "${aws_subnet.public_subnet_2.id }"]

  tag {
    key                 = "foo"
    value               = "bar"
    propagate_at_launch = true
  }
}