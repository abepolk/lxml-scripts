terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "6.37.0"
        }
    }
    required_version = "~> 1.12.1"
}

#locals {
#    location = "us-central1"
#}

provider "google" {
    project = var.project_id
}

resource "random_id" "startup_script_bucket_id" {
  byte_length = 8
}

resource "google_storage_bucket" "startup_script_bucket" {
    name = "${random_id.startup_script_bucket_id.hex}-startup-script-bucket"
#    location = local.location
    location = "us-central1"
    storage_class = "STANDARD"
    # uniform_bucket_level_access disables ACLs, which are only useful
    # in legacy contexts and migrations from AWS
    uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "startup_script" {
    bucket = google_storage_bucket.startup_script_bucket.name
    name = "startup-script"
    source = "build_lxml_and_open_python.sh"
}

# The Cloud Build was a work in progress, but unless we are doing some sort of CI/CD, I don't think it's necessary.
# Just add the file in the Storage resource instead, as above.

## TODO not sure if this needs to be v2 for some reason
#resource "google_cloudbuild_trigger" "copy_to_gcs" {
#    location = local.location
#    build {
#        step {
#            name = "google/cloud-sdk:slim"
#            entrypoint = "gcloud"
#            args = ["storage", "cp", "build_lxml_and_open_python.sh", ]
#            script = [
#                "git clone https://github.com/abepolk/lxml-scripts.git",
#                "gcloud storage cp lxml-scripts/build_lxml_and_open_python.sh gs://${google_storage_bucket.startup_script_bucket.name}"
#            ]
#        }
#    }
#}
