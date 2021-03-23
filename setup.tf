locals {
  owner         = "moosterhof"
  se-region     = "apj"
  purpose       = "demo"
  ttl           = "24"
  tfe-workspace = "mongodb-atlas-hashicorp"
}

locals {
  # tags to be assigned to all resources
  common_tags = {
    owner         = local.owner
    se-region     = local.se-region
    purpose       = local.purpose
    ttl           = local.ttl
    terraform     = "true"
    tfe-workspace = local.tfe-workspace
  }
}
