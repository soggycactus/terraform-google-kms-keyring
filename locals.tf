locals {
  keys = { for key in var.keys : key["key_name"] => key }
}