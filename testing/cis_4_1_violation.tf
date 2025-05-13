resource "google_compute_instance" "empty_sa_compute_instance_violation" {
  name         = "my-instance-violation-1"
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
}

resource "google_compute_instance" "default_sa_compute_instance_violation" {
  name         = "my-instance-violation-2"
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
    email  = "565002515140-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}