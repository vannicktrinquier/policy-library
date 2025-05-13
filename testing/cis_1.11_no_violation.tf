resource "google_project_iam_binding" "kms_admin_no_violation_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/cloudkms.admin"

  members = [
    "user:good1@google.com"
  ]
}

resource "google_project_iam_binding" "kms_encrypter_decrypter_no_violation_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "user:good2@google.com"
  ]
}