resource "aws_autoscaling_group" "asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 2
  vpc_zone_identifier  = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  health_check_type         = "EC2"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.app_tg.arn]
}
