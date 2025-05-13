resource "google_project_iam_binding" "sa_user_no_violation_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/iam.serviceAccountUser"

  members = [
    "user:good1@google.com"
  ]
}

resource "google_project_iam_binding" "sa_admin_no_violation_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/iam.serviceAccountAdmin"

  members = [
    "user:good2@google.com"
  ]
}