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



resource "google_compute_instance" "instance-2" {
  boot_disk {
    auto_delete = true
    device_name = "instance-1"

    initialize_params {
      image = "projects/ml-images/global/images/c1-deeplearning-tf-2-15-gpu-v20240111-debian-11-py310"
      size  = 60
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  guest_accelerator {
    count = 1
    type  = "projects/full-chess/zones/us-central1-b/acceleratorTypes/nvidia-tesla-t4"
  }

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "n1-standard-4"

  metadata = {
    ssh-keys = "ethancruz3141:ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBKkB6tpd7RBEM6tDqbNI76D1c4y8mEStH/KNhALWwPgWRMdCdcyD7fVmPFQyj4Z5+Jgg4cHQBJnMkRsA/8ozowQ= google-ssh {\"userName\":\"ethancruz3141@gmail.com\",\"expireOn\":\"2024-02-06T17:08:22+0000\"}\nethancruz3141:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCz04z6d93ZgyLR3NWLBvHapD2F3IYNJArnhaxjApaSHFvnAq3fqyaKFXWmnC/2VCUgk2Om2K7JcCMOID+GerV+qfsn9SApNUe/vzLAqll5J1Fz8Mq8IR7chQi2mnPEPJB71w675i3ziSYnTwk2w37GTWHTdm1IrtSPbqOFg+OMOjvYNIH1gM0MxCsMSi0jVqquLqAg5KYffQsPvcifC9omg2toC+1lYmHP0yPiXHwW+RP+lu9uL3FAOc8rTDGKwRviTNSBzLsujLd9rKjlaJaLb7gNYQsmxBwQgfLVTG1ynOs4E29tPuLJsV7uuEHVDRAYV2UU6Tnvju5AD3UsB49x google-ssh {\"userName\":\"ethancruz3141@gmail.com\",\"expireOn\":\"2024-02-06T17:08:37+0000\"}"
  }

  name = "instance-2"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/full-chess/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
    preemptible         = false
    provisioning_model  = "SPOT"
  }

  service_account {
    email  = "577247944050-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "us-central1-b"
}