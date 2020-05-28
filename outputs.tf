output "keyring_self_link" {
  value       = google_kms_key_ring.key_ring.self_link
  description = "The self link of the created KeyRing. Its format is projects/{projectId}/locations/{location}/keyRings/{keyRingName}"
}