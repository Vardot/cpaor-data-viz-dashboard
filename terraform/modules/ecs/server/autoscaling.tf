resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.cpaor_streamlit_scaling_max_capacity
  min_capacity       = var.cpaor_streamlit_scaling_min_capacity
  resource_id        = "service/${aws_ecs_cluster.cluster.id}/${var.ecs_service_name}-${var.environment}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  role_arn           = aws_iam_role.ecs-autoscale-role.arn
  depends_on         = [aws_ecs_service.service]
}

resource "aws_appautoscaling_policy" "scale_up_policy" {
  name = "cpaor-streamlit-scale-up-policy-${var.environment}"

  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 30
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
  depends_on = [aws_appautoscaling_target.ecs_target]
}

resource "aws_appautoscaling_policy" "scale_down_policy" {
  name = "cpaor-streamlit-scale-down-policy-${var.environment}"

  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [aws_appautoscaling_target.ecs_target]
}