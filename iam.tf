resource "google_kms_crypto_key_iam_policy" "iam_policies" {
  for_each      = local.keys
  crypto_key_id = google_kms_crypto_key.keys[each.value["key_name"]].id
  policy_data   = data.google_iam_policy.policy[each.value["key_name"]].policy_data
}

data "google_iam_policy" "policy" {
  for_each = local.keys

  dynamic "binding" {
    for_each = each.value["permissions"] != null ? each.value["permissions"] : []
    content {
      role    = binding.value["role"]
      members = binding.value["members"]

      condition {
        title       = binding.value["condition"]["title"]
        description = binding.value["condition"]["description"]
        expression  = binding.value["condition"]["expression"]
      }
    }
  }
}