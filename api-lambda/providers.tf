terraform {
  backend "s3" {
    bucket         = "terrafrom-state-kruger"
    key            = "global/mystatefile/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-kruger"
    encrypt        = true 
  }
}

provider "aws" {
  region = "us-east-1"
  # shared_credentials_files = ["/Users/.aws/credentials"]
}
