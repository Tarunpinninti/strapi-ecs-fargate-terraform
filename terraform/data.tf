# ----------------------------------------
# ECS Cluster (existing)
# ----------------------------------------
data "aws_ecs_cluster" "strapi_cluster" {
  cluster_name = "strapi-fargate-cluster"
}

# ----------------------------------------
# VPC (the one you already use)
# ----------------------------------------
data "aws_vpc" "strapi_vpc" {
  filter {
    name   = "tag:Name"
    values = ["strapi-vpc"]
  }
}

# ----------------------------------------
# Subnets ONLY from this VPC
# ----------------------------------------
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.strapi_vpc.id]
  }
}

# ----------------------------------------
# Security Group (name + VPC = UNIQUE)
# ----------------------------------------
data "aws_security_group" "strapi_sg" {
  filter {
    name   = "group-name"
    values = ["strapi-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.strapi_vpc.id]
  }
}

# ----------------------------------------
# ECR Repository (existing)
# ----------------------------------------
data "aws_ecr_repository" "strapi" {
  name = "strapi-ecr-repo"
}

# ----------------------------------------
# IAM Roles (existing)
# ----------------------------------------
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
}

# ----------------------------------------
# CloudWatch Logs (existing)
# ----------------------------------------
data "aws_cloudwatch_log_group" "strapi_logs" {
  name = "/ecs/strapi"
}
