# --------------------------------------
# EXISTING AWS RESOURCES (DO NOT CREATE)
# --------------------------------------

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
}

data "aws_ecr_repository" "strapi" {
  name = "strapi-ecr-repo"
}

data "aws_cloudwatch_log_group" "strapi_logs" {
  name = "/ecs/strapi"
}

data "aws_ecs_cluster" "strapi_cluster" {
  cluster_name = "strapi-fargate-cluster"
}
