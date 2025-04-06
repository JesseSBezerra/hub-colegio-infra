terraform {
  backend "s3" {
    bucket         = "hub-colegio-infra-terraform"
    key            = "infra/terraform.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "dynamodb" {
  source = "./modules/dynamodb"
}
