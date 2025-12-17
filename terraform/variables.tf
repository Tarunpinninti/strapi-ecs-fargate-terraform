variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ECS is running"
  type        = string
}
