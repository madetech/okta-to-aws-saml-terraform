terraform {
  required_version = "~> 0.12.0"
}

provider "aws" {
  region  = "eu-west-2"
  version = "~> 2.21"
}

module "okta_label" {
  source    = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=tags/0.4.0"
  namespace = "auth"
  stage     = terraform.workspace
  name      = "okta-SAML"
  delimiter = "-"
}
