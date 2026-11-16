terraform {
  backend "s3" {
    bucket = "tfstate"
    key    = "terraform.tfstate"
    region = "garage"

    endpoints = {
      s3 = "http://192.168.20.90:3900"
    }

    use_path_style              = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_s3_checksum            = true
  }
}
