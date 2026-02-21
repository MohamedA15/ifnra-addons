terraform {
  backend "s3" {
    bucket       = "eks-terraform-state-mo"
    key          = "addons/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
