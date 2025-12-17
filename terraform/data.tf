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

# Existing CloudWatch Log Group
data "aws_cloudwatch_log_group" "strapi_logs" {
  name = "/ecs/strapi"
}

# 🔥 Existing Security Group (filter by name AND VPC)
data "aws_security_group" "strapi_sg" {
  filter {
    name   = "group-name"
    values = ["strapi-sg"]
  }
}

# 🔥 Get VPC from the security group
data "aws_vpc" "strapi_vpc" {
  id = data.aws_security_group.strapi_sg.vpc_id
}

# 🔥 Get ONLY subnets from that VPC
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.strapi_vpc.id]
  }
}
