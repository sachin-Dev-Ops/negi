resource "aws_autoscaling_group" "web" {
  name                      = "squizify-staging-web-asg"
  min_size                  = 3
  max_size                  = 6
  health_check_type         = "EC2"
  health_check_grace_period = 300
  # wait_for_elb_capacity     = 3
  vpc_zone_identifier = module.vpc.private_subnet_ids
  # target_group_arns         = var.web_target_groups

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  lifecycle {
    ignore_changes = [desired_capacity, target_group_arns]
  }
}

resource "aws_autoscaling_policy" "web_scale_up" {
  name                   = "WebScaleUpPolicy"
  autoscaling_group_name = aws_autoscaling_group.web.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_autoscaling_policy" "web_scale_down" {
  name                   = "WebScaleDownPolicy"
  autoscaling_group_name = aws_autoscaling_group.web.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "web_high_cpu_alarm" {
  alarm_description   = "Alarm if average CPU load is high"
  alarm_actions       = [aws_autoscaling_policy.web_scale_up.arn]
  alarm_name          = "WebHighCPUAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "70"
  evaluation_periods  = "2"
  period              = "300"
  statistic           = "Average"
}

resource "aws_cloudwatch_metric_alarm" "web_low_cpu_alarm" {
  alarm_description   = "Alarm if average CPU load is low"
  alarm_actions       = [aws_autoscaling_policy.web_scale_down.arn]
  alarm_name          = "WebLowCPUAlarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "30"
  evaluation_periods  = "2"
  period              = "300"
  statistic           = "Average"
}

resource "aws_autoscaling_group" "cron_01" {
  name                      = "squizify-${var.env}-cron-01-asg"
  min_size                  = 1
  max_size                  = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  vpc_zone_identifier       = [module.vpc.private_subnet_ids[0]]

  launch_template {
    id      = aws_launch_template.cron_01.id
    version = aws_launch_template.cron_01.latest_version
  }
}

resource "aws_autoscaling_policy" "cron_01_scale_up" {
  name                   = "Cron01ScaleUpPolicy"
  autoscaling_group_name = aws_autoscaling_group.cron_01.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_autoscaling_policy" "cron_01_scale_down" {
  name                   = "Cron01ScaleDownPolicy"
  autoscaling_group_name = aws_autoscaling_group.cron_01.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "cron_01_high_cpu_alarm" {
  alarm_description   = "Alarm if average CPU load is high"
  alarm_actions       = [aws_autoscaling_policy.cron_01_scale_up.arn]
  alarm_name          = "Cron01HighCPUAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "70"
  evaluation_periods  = "2"
  period              = "300"
  statistic           = "Average"
}

resource "aws_cloudwatch_metric_alarm" "cron_01_low_cpu_alarm" {
  alarm_description   = "Alarm if average CPU load is low"
  alarm_actions       = [aws_autoscaling_policy.cron_01_scale_down.arn]
  alarm_name          = "Cron01LowCPUAlarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "30"
  evaluation_periods  = "2"
  period              = "300"
  statistic           = "Average"
}

resource "aws_autoscaling_group" "cron_02" {
  name                      = "squizify-${var.env}-cron-02-asg"
  min_size                  = 1
  max_size                  = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  vpc_zone_identifier       = [module.vpc.private_subnet_ids[1]]

  launch_template {
    id      = aws_launch_template.cron_02.id
    version = aws_launch_template.cron_02.latest_version
  }
}

resource "aws_autoscaling_policy" "cron_02_scale_up" {
  name                   = "Cron02ScaleUpPolicy"
  autoscaling_group_name = aws_autoscaling_group.cron_02.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}

resource "aws_autoscaling_policy" "cron_02_scale_down" {
  name                   = "Cron02ScaleDownPolicy"
  autoscaling_group_name = aws_autoscaling_group.cron_02.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "cron_02_high_cpu_alarm" {
  alarm_description   = "Alarm if average CPU load is high"
  alarm_actions       = [aws_autoscaling_policy.cron_02_scale_up.arn]
  alarm_name          = "Cron02HighCPUAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "70"
  evaluation_periods  = "2"
  period              = "300"
  statistic           = "Average"
}

resource "aws_cloudwatch_metric_alarm" "cron_02_low_cpu_alarm" {
  alarm_description   = "Alarm if average CPU load is low"
  alarm_actions       = [aws_autoscaling_policy.cron_02_scale_down.arn]
  alarm_name          = "Cron02LowCPUAlarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  namespace           = "AWS/EC2"
  metric_name         = "CPUUtilization"
  threshold           = "30"
  evaluation_periods  = "2"
  period              = "300"
  statistic           = "Average"
}
