resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service"
  cluster         = data.aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.strapi_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [
      "subnet-0e588ce213557c0c6",
      "subnet-08ef0eec724be3213"
    ]
    security_groups = ["sg-0e26bc4d1f2c04669"]
    assign_public_ip = true
  }
}

