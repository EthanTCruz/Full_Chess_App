terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}
provider "google" {
  credentials = file("C:/Users/ethan/git/Full_Chess_App/terraform/secret.json")
  region      = var.region
}

data "google_project" "project" {
project_id = "full-chess"
}



resource "google_compute_instance" "chess-model" {
    project = data.google_project.project.project_id
    name         = "chess-model"
    machine_type = var.machine_type
    zone         = var.zone



  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  scheduling {
    preemptible = true
    automatic_restart = false
    on_host_maintenance = "TERMINATE"
  }

  network_interface {
    network = "default"
        access_config {
    }
  }

 

  metadata_startup_script = file("${path.module}/startup-script.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
}