variable "mongodb_public_key" {
  description = "The public API key for MongoDB Atlas"
}
variable "mongodb_private_key" {
  description = "The private API key for MongoDB Atlas"
}
variable "atlasprojectid" {
  description = "Atlas project ID"
}
variable "aws_access_key" {
  description = "The access key for AWS Account"
}
variable "aws_secret_key" {
  description = "The secret key for AWS Account"
}
variable "atlas_region" {
  default     = "AP_SOUTHEAST_1"
  description = "Atlas Region"
}
variable "aws_region" {
  default     = "ap-southeast-1"
  description = "AWS Region"
}
variable "aws_account_id" {
  description = "My AWS Account ID"
}
variable "atlasorgid" {
  description = "Atlas Org ID"
}
variable "atlas_vpc_cidr" {
  description = "Atlas CIDR"
}
