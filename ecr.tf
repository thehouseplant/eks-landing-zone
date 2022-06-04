resource "aws_ecr_repository" "repo" {
  name = "${var.prefix}-REPO"
}