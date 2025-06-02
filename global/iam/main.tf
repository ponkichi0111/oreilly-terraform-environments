provider "aws" {
  region = "ap-northeast-1"
  profile = "dev"
}

# resource "aws_iam_user" "example" {
#   for_each = toset(var.user_names)
#   name     = each.value
# }

# output "all_users" {
#   value = values(aws_iam_user.example)[*].arn
# }

output "upper_names" {
  value = [for name in var.user_names : upper(name)]
}