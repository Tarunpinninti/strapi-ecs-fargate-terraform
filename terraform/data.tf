# Existing ECS Cluster
data "aws_ecs_cluster" "strapi_cluster" {
  cluster_name = "strapi-fargate-cluster"
}

# Existing ECR Repo
data "aws_ecr_repository" "strapi" {
  name = "strapi-ecr-repo"
}

# Existing IAM Roles
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
}

# Existing CloudWatch Logs
data "aws_cloudwatch_log_group" "strapi_logs" {
  name = "/ecs/strapi"
}

# Existing Network
data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["strapi-public-a", "strapi-public-b"]
  }
}

data "aws_security_group" "strapi_sg" {
  filter {
    name   = "tag:Name"
    values = ["strapi-sg"]
  }

  filter {
    name   = "vpc-id"
    values = ["vpc-05ba494c8673c0267"] # ← YOUR EXISTING VPC ID
  }
}

