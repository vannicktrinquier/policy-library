resource "google_project_iam_binding" "kms_admin_violation_project_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/cloudkms.admin"

  members = [
    "user:bad@google.com"
  ]
}

resource "google_project_iam_binding" "kms_encrypter_decrypter_violation_project_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "user:bad@google.com"
  ]
}

resource "google_folder_iam_binding" "kms_admin_violation_folder_iam_binding" {
  folder = "644063953999"
  role    = "roles/cloudkms.admin"

  members = [
    "user:bad@google.com"
  ]
}

resource "google_folder_iam_binding" "kms_encrypter_decrypter_violation_folder_iam_binding" {
  folder = "644063953999"
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "user:bad@google.com"
  ]
}