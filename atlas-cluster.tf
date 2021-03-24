
locals {
  atlas_provider_name = "AWS"
}

resource "mongodbatlas_cluster" "cluster-atlas" {
  project_id                   = var.atlasprojectid
  name                         = "moosterhof-mongodb-terraform"
  num_shards                   = 1
  replication_factor           = 3
  provider_backup_enabled      = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.2"

  //Provider settings
  provider_name               = local.atlas_provider_name
  disk_size_gb                = 10
  provider_disk_iops          = 100
  provider_volume_type        = "STANDARD"
  provider_encrypt_ebs_volume = true
  provider_instance_size_name = "M10"
  provider_region_name        = var.atlas_region
}

output "atlasclusterstring" {
  value = mongodbatlas_cluster.cluster-atlas.connection_strings[0].standard_srv
}

# Create the peering connection request
resource "mongodbatlas_network_peering" "test" {
  accepter_region_name   = var.aws_region
  project_id             = var.atlasprojectid
  container_id           = mongodbatlas_cluster.cluster-atlas.container_id
  provider_name          = local.atlas_provider_name
  route_table_cidr_block = "192.168.0.0/24"
  vpc_id                 = aws_vpc.primary.id
  aws_account_id         = data.aws_caller_identity.current.account_id
}

# the following assumes an AWS provider is configured
# Accept the peering connection request
resource "aws_vpc_peering_connection_accepter" "aws_peer" {
  vpc_peering_connection_id = mongodbatlas_network_peering.test.connection_id
  auto_accept               = true
  tags = {
    Name = "moosterhof-mongodb-link"
    Side = "Accepter"

    owner         = "moosterhof"
    se-region     = "apj"
    purpose       = "demo"
    ttl           = "24"
    terraform     = "true"
    tfe-workspace = "mongodb-atlas-hashicorp"
  }
}

# MongoDB Atlas will automatically create this once a cluster has been provisioned
# resource "mongodbatlas_network_container" "test" {
#   project_id       = var.atlasprojectid
#   atlas_cidr_block = "192.168.208.0/21"
#   provider_name    = local.atlas_provider_name
#   region_name      = var.atlas_region
# }

# TODO: fix ptfe
# output "plstring" {
#   value = lookup(mongodbatlas_cluster.cluster-atlas.connection_strings[0].aws_private_link_srv, aws_vpc_endpoint.ptfe_service.id)
#}

# create user
# TODO: use Vault
resource "mongodbatlas_database_user" "test" {
  username           = "test-acc-username"
  password           = "test-acc-password"
  project_id         = var.atlasprojectid
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = "dbforApp"
  }

  roles {
    role_name     = "readAnyDatabase"
    database_name = "admin"
  }

  labels {
    key   = "My Key"
    value = "My Value"
  }

  scopes {
    name   = mongodbatlas_cluster.cluster-atlas.name
    type = "CLUSTER"
  }
}

# access list for internet
resource "mongodbatlas_project_ip_access_list" "internet-ial" {
  project_id = var.atlasprojectid
  cidr_block = "103.6.149.81/32"
  comment    = "cidr block for tf acc testing"
}

resource "mongodbatlas_project_ip_access_list" "aws-peer-ial" {
  project_id         = var.atlasprojectid
  aws_security_group = aws_security_group.primary_default.id
  comment            = "IAL for awsSecurityGroup"

  depends_on = [mongodbatlas_network_peering.test]
}

