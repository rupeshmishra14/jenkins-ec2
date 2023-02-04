# --- root/backend.tf ---

terraform {
  backend "s3" {
    bucket = "week-1-project-11-01-23"
    key    = "remote.tfstate"
    region = "us-east-1"
  }
}
