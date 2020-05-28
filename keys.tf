resource "google_kms_crypto_key" "keys" {
  for_each        = local.keys
  name            = each.value["key_name"]
  key_ring        = google_kms_key_ring.key_ring.self_link
  purpose         = each.value["purpose"]
  rotation_period = each.value["rotation_period"]

  dynamic "version_template" {
    for_each = each.value["version_template"] != null ? [each.value["version_template"]] : []
    content {
      algorithm        = version_template.value["algorithm"]
      protection_level = version_template.value["protection_level"]
    }
  }
}