# ----------------------------------------
# VPC (explicit – no ambiguity)
# ----------------------------------------
data "aws_vpc" "strapi_vpc" {
  id = var.vpc_id
}
