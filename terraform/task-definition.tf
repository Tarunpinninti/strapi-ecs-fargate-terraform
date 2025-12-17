# --------------------------------------
# CloudWatch Logs
# --------------------------------------
resource "aws_cloudwatch_log_group" "strapi_logs" {
  name              = "/ecs/strapi"
  retention_in_days = 7
}

# --------------------------------------
# ECS Task Definition
# --------------------------------------
resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "${aws_ecr_repository.strapi.repository_url}:${var.image_tag}"
      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
        { name = "NODE_ENV", value = "production" },

        { name = "ADMIN_JWT_SECRET", value = "REPLACE_AT_RUNTIME" },
        { name = "API_TOKEN_SALT",   value = "REPLACE_AT_RUNTIME" },
        { name = "JWT_SECRET",       value = "REPLACE_AT_RUNTIME" },
        { name = "APP_KEYS",         value = "REPLACE_AT_RUNTIME" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.strapi_logs.name
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
