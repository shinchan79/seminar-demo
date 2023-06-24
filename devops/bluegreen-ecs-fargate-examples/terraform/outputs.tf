output "task_definition_arn" {
  value = try(aws_ecs_task_definition.task_definition.arn, "")
}