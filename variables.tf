variable "mongodb_public_key" {
  description = "The public API key for MongoDB Atlas"
}
variable "mongodb_private_key" {
  description = "The private API key for MongoDB Atlas"
}
variable "atlasprojectid" {
  description = "Atlas project ID"
}
variable "atlas_region" {
  default     = "US_EAST_1"
  description = "Atlas Region"
}
variable "aws_region" {
  default     = "us-east-1"
  description = "AWS Region"
}
# variable "aws_account_id" {
#   description = "My AWS Account ID"
# }
variable "atlas_vpc_cidr" {
  description = "Atlas CIDR"
}
