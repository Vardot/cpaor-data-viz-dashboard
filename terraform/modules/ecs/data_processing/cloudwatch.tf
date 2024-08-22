resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/cpaor-data-processing-${var.environment}"
  retention_in_days = 30

  tags = {
    Name = "cw-log-group-cpaor-data-processing-${var.environment}"
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "log-stream-cpaor-data-processing-${var.environment}"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}