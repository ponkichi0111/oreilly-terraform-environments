provider "aws" {
  region  = "ap-northeast-1"
  profile = "dev"
}

module "webserver-cluster" {
  source = "github.com/ponkichi0111/oreilly-terraform-modules//services/webserver-cluster?ref=v0.0.1"

  cluster_name           = "webservices-prod"
  db_remote_state_bucket = "terraform-state-hiroyuki-2025-05-31"
  db_remote_stae_key     = "prod/data-stores/mysql/terraform.tfstate"

  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 5
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name = "scale-out-during-business-hours"
  min_size              = 2
  max_size              = 10
  desired_capacity      = 10
  recurrence            = "0 9 * * *"

  autoscaling_group_name = module.webserver-cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name = "scale-in-at-night"
  min_size              =  2
  max_size              = 10
  desired_capacity      = 2
  recurrence            = "0 17 * * *"

  autoscaling_group_name = module.webserver-cluster.asg_name
}