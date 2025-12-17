resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg"
  description = "Allow Strapi traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Strapi port"
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "strapi-sg"
  }
}
