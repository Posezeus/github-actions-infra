resource "aws_launch_template" "webapp" {
  name                 = "asg"
  image_id             = "ami-001aebc937eac39d4"
  instance_type       = "t2.micro"
  vpc_security_group_ids = var.security_group_ec2
  key_name = "calikp"

}


resource "aws_autoscaling_group" "webapp" {
  name                 = var.project-name
  target_group_arns   = [var.target_group_arn]
  vpc_zone_identifier = var.private_subnet
  launch_template {
    id      = aws_launch_template.webapp.id
    version = "$Latest"
  }
  min_size             = 2
  max_size             = 4
  health_check_type    = "EC2"
  health_check_grace_period = 300
  desired_capacity     = 2

  tag {
    key                 = "Name"
    value               = "example"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

  termination_policies = ["OldestInstance", "Default"]

}

resource "aws_autoscaling_attachment" "webapp" {
  autoscaling_group_name = aws_autoscaling_group.webapp.name
  alb_target_group_arn   = var.target_group_arn
}
