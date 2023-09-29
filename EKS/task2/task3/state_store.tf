# terraform {
#   backend "s3" {
#     bucket         = "terraform-states"
#     key            = "test-101/rattle-eks01/task3/terraform.tfstate"
#     region         = "ap-southeast-1"
#     profile        = "central"
#     dynamodb_table = "terraform-states"
#     encrypt        = true
#   }
# }