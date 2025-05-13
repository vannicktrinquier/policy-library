resource "google_service_account" "custom_sa" {
  project      = "dbs-validator-kcc-29ae"
  account_id   = "my-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "custom_sa_compute_instance_no_violation" {
  name         = "my-instance-no-violation"
  machine_type = "n2-standard-2"
  project      = "dbs-validator-kcc-29ae"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"
  }

  service_account {
    email  = google_service_account.custom_sa.email
    scopes = ["cloud-platform"]
  }
}
