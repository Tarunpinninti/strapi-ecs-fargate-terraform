# ----------------------------------------
# Existing ECS Cluster
# ----------------------------------------
data "aws_ecs_cluster" "strapi_cluster" {
  cluster_name = "strapi-fargate-cluster"
}

# ----------------------------------------
# Existing ECS Service (source of truth)
# ----------------------------------------
data "aws_ecs_service" "strapi_service" {
  cluster_arn = data.aws_ecs_cluster.strapi_cluster.arn
  service_name = "strapi-service"
}

# ----------------------------------------
# Security Group (EXACT one used by ECS)
# ----------------------------------------
data "aws_security_group" "strapi_sg" {
  id = data.aws_ecs_service.strapi_service.network_configuration[0].security_groups[0]
}

# ----------------------------------------
# VPC from that Security Group
# ----------------------------------------
data "aws_vpc" "strapi_vpc" {
  id = data.aws_security_group.strapi_sg.vpc_id
}

# ----------------------------------------
# Subnets ONLY from that VPC
# ----------------------------------------
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.strapi_vpc.id]
  }
}

# ----------------------------------------
# Existing ECR Repository
# ----------------------------------------
data "aws_ecr_repository" "strapi" {
  name = "strapi-ecr-repo"
}

# ----------------------------------------
# Existing IAM Roles
# ----------------------------------------
data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_role" "ecs_task_role" {
  name = "ecsTaskRole"
}

# ----------------------------------------
# Existing CloudWatch Log Group
# ----------------------------------------
data "aws_cloudwatch_log_group" "strapi_logs" {
  name = "/ecs/strapi"
}
