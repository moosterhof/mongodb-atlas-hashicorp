terraform {
    required_providers {
        mongodbatlas = {
            source = "mongodb/mongodbatlas"
        }
    }
}

provider "mongodbatlas" {
}

provider "aws" {
  region     = var.aws_region
}
