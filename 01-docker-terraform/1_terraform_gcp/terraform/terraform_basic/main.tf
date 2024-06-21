terraform {
  required_providers {
    google = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "zoomcamptest" {
  cidr_block = "10.0.0.0/16"
}

# resource "google_storage_bucket" "data-lake-bucket" {
#   name          = "<Your Unique Bucket Name>"
#   location      = "US"

#   # Optional, but recommended settings:
#   storage_class = "STANDARD"
#   uniform_bucket_level_access = true

#   versioning {
#     enabled     = true
#   }

#   lifecycle_rule {
#     action {
#       type = "Delete"
#     }
#     condition {
#       age = 30  // days
#     }
#   }

#   force_destroy = true
# }


# resource "google_bigquery_dataset" "dataset" {
#   dataset_id = "<The Dataset Name You Want to Use>"
#   project    = "<Your Project ID>"
#   location   = "US"
# }