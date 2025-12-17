resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service"
  cluster         = data.aws_ecs_cluster.strapi_cluster.arn
  task_definition = aws_ecs_task_definition.strapi_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.public.ids
    security_groups = [data.aws_security_group.strapi_sg.id]
    assign_public_ip = true
  }
}
