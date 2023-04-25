terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}
#   backend "s3" {
#     bucket                      = "config"
#     key                         = "exemplo-aws-api-gateway.tfstate"
#     access_key                  = "teste"
#     secret_key                  = "teste"
#     region                      = "us-east-1"
#     skip_credentials_validation = true
#     skip_metadata_api_check     = true
#     skip_region_validation      = true
#     force_path_style            = true
#     endpoint                    = "http://localhost:4566"
#     sts_endpoint                = "http://localhost:4566"
#   }

provider "aws" {
  access_key                  = "AKIA5IN6WGRHF3ZLWYOW"
  secret_key                  = "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"
  }
