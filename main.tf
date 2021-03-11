terraform {
    required_providers {
        mongodbatlas = {
            source = "mongodb/mongodbatlas"
        }
    }
}

# Configure the MongoDB Atlas Provider
provider "mongodbatlas" {
  public_key = var.mongodbatlas_public_key
  private_key  = var.mongodbatlas_private_key
}

#Create the resources
# ...


output "atlasclusterstring" {
    value = mongodbatlas_cluster.cluster-atlas.connection_strings
}
