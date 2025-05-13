resource "google_project_iam_binding" "sa_user_violation_project_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/iam.serviceAccountUser"

  members = [
    "user:bad@google.com"
  ]
}

resource "google_project_iam_binding" "sa_admin_violation_project_iam_binding" {
  project = "dbs-validator-kcc-29ae"
  role    = "roles/iam.serviceAccountAdmin"

  members = [
    "user:bad@google.com"
  ]
}

resource "google_folder_iam_binding" "sa_user_violation_folder_iam_binding" {
  folder = "644063953999"
  role    = "roles/iam.serviceAccountUser"

  members = [
    "user:bad@google.com"
  ]
}

resource "google_folder_iam_binding" "sa_admin_violation_folder_iam_binding" {
  folder = "644063953999"
  role    = "roles/iam.serviceAccountAdmin"

  members = [
    "user:bad@google.com"
  ]
}