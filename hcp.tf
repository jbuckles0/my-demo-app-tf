provider "hcp" {
  project_id = "4d2ccc41-8a5b-446a-8e09-c7c0924f8dca"
}

data "hcp_packer_artifact" "ubuntu-east" {
  bucket_name  = "packer-demo"
  channel_name = "development"
  platform     = "aws"
  region       = "us-east-2"
}
