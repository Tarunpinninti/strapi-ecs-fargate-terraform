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

# Existing VPC (ONLY HERE)
data "aws_vpc" "strapi_vpc" {
  tags = {
    Name = "strapi-vpc"
  }
}

# Public subnets ONLY from this VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.strapi_vpc.id]
  }
}

# Security Group (unique by name + VPC)
data "aws_security_group" "strapi_sg" {
  name   = "strapi-sg"
  vpc_id = data.aws_vpc.strapi_vpc.id
}
