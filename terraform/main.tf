# -------------------------------
# ECR Repository for Strapi Image
# -------------------------------
resource "aws_ecr_repository" "strapi" {
  name = "strapi-ecr-repo"

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"
}

# -------------------------------
# ECS Cluster (Fargate)
# -------------------------------
resource "aws_ecs_cluster" "strapi_cluster" {
  name = "strapi-fargate-cluster"
}

