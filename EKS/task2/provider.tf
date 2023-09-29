provider "aws" {
  alias                   = "staging"
  region                  = "${var.region}"
  shared_credentials_files = ["${pathexpand("~/.aws/credentials")}"]
  profile                 = "${var.staging_profile}"
}

provider "aws" {
  alias                   = "stg-us-east-1"
  region                  = "us-east-1"
  shared_credentials_files = ["${pathexpand("~/.aws/credentials")}"]
  profile                 = "${var.staging_profile}"
}

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_files = ["${pathexpand("~/.aws/credentials")}"]
  profile                 = "${var.staging_profile}"
}

# provider "external" {
#   version = "~> 1.2.0"
# }
