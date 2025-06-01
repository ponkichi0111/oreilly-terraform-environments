provider "aws" {
  region = "ap-northeast-1"
  profile = "dev"
}

resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name = var.user_names[count.index]
}