terraform {
  backend "s3" {
    bucket = "w7-ap-tera-bucket"
    key    = "seven/terraform.tfstate"
    region = "us-east-1"
    #use_lockfile = true
  }
}