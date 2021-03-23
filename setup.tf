locals {
  # owner         = split(local.caller_user, ":")[1]
  owner     = "moosterhof"
  se-region = "apj"
  purpose   = "demo"
  ttl       = "24"
}

locals {
  # tags to be assigned to all resources
  common_tags = {
    owner         = local.owner
    se-region     = local.se-region
    purpose       = local.purpose
    ttl           = local.ttl
    terraform     = "true"
    tfe-workspace = terraform.workspace
  }
}
