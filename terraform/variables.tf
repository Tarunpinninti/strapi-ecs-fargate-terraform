variable "image_tag" {
  description = "Docker image tag pushed to ECR"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID where ECS is running"
  type        = string
}
