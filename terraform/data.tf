# ----------------------------------------
# Existing AWS Infrastructure (DATA)
# ----------------------------------------

data "aws_ecs_cluster" "strapi_cluster" {
  cluster_name = "strapi-fargate-cluster"
}

data "aws_ecr_repository" "strapi" {
  name = "strapi-ecr-repo"
}

data "aws_cloudwatch_log_group" "strapi_logs" {
  name = "/ecs/strapi"
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
}

# Pin exact VPC (NO ambiguity)
data "aws_vpc" "strapi_vpc" {
  id = var.vpc_id
}

# Subnets ONLY from this VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.strapi_vpc.id]
  }
}

# Security Group by name + VPC
data "aws_security_group" "strapi_sg" {
  name   = "strapi-sg"
  vpc_id = data.aws_vpc.strapi_vpc.id
}
