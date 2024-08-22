resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/cpaor-streamlit-${var.environment}"
  retention_in_days = 30

  tags = {
    Name = "cw-log-group-cpaor-streamlit-${var.environment}"
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "log-stream-cpaor-streamlit-${var.environment}"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}

resource "aws_cloudwatch_metric_alarm" "memory_high" {
  alarm_name          = "cpaor-streamlit-mem-high-${var.environment}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_period_max
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.monitoring_period
  statistic           = "Average"
  threshold           = var.cpaor_streamlit_max_mem_target_value
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.service.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_up_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "memory_low" {
  alarm_name          = "cpaor-streamlit-mem-low-${var.environment}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_period_min
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = var.monitoring_period
  statistic           = "Average"
  threshold           = var.cpaor_streamlit_min_mem_target_value
  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = aws_ecs_service.service.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_down_policy.arn]
}