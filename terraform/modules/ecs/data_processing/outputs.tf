
output "ecs_sec_grp_id" {
  value = aws_security_group.ecs_sg.id
}

output "ecs_cluster_name_shared" {
  value = "${var.ecs_cluster_name}-${var.environment}"
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs_sg.id
}

output "iam_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "iam_ecs_task_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "iam_ecs_task_execution_policy_arn" {
  value = aws_iam_role_policy_attachment.ecs_task_execution_role
}