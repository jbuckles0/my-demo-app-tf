provider "hcp" {}

data "hcp_packer_artifact" "ubuntu-east" {
  bucket_name  = "packer-demo"
  channel_name = "development"
  platform     = "aws"
  region       = "us-east-2"
}
