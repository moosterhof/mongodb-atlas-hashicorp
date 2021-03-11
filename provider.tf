terraform {
    required_providers {
        mongodbatlas = {
            source = "mongodb/mongodbatlas"
        }
    }
}

provider "mongodbatlas" {
  public_key  = var.mongodb_public_key
  private_key = var.mongodb_private_key
}

provider "aws" {
#  access_key = var.aws_access_key
#  secret_key = var.aws_secret_key
  region     = var.aws_region
}
