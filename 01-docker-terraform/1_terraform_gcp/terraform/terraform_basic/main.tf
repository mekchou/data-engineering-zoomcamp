terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "web" {
  ami           = "ami-09040d770ffe2224f"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
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