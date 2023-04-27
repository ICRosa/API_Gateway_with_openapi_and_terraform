terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}
#   backend "s3" {
#     bucket                      = "sharedstatebucket"
#     key                         = "ToDo_API.tfstate"
#     access_key                  = var.access_key
#     secret_key                  = var.secret_key
#     region                      = "us-east-1"
#   }

provider "aws" {
  access_key                  = var.access_key
  secret_key                  = var.secret_key
  }
