# ECS Cluster
data "aws_ecs_cluster" "strapi_cluster" {
  cluster_name = "strapi-fargate-cluster"
}

# ECR Repository
data "aws_ecr_repository" "strapi" {
  name = "strapi-ecr-repo"
}

# IAM Roles
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
}

# CloudWatch Logs
data "aws_cloudwatch_log_group" "strapi_logs" {
  name = "/ecs/strapi"
}

# 🔒 LOCKED VPC (NO MORE MULTIPLE MATCHES)
data "aws_vpc" "strapi_vpc" {
  id = "vpc-05ba494c8673c0267"
}

# Public Subnets ONLY from this VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.strapi_vpc.id]
  }
}

# Security Group (unique inside VPC)
data "aws_security_group" "strapi_sg" {
  name   = "strapi-sg"
  vpc_id = data.aws_vpc.strapi_vpc.id
}
