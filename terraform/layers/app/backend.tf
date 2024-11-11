terraform {
  backend "s3" {
    bucket         = "937405989913-eu-west-2-grad-lab-1-tf-state"
    key            = "dev/app/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "937405989913-eu-west-2-grad-lab-1-tf-state"
  }
}
