policy "terraform-maintenance-windows" {
  source            = "./restrict-az-mongodb.sentinel"
  enforcement_level = "hard-mandatory"
}
