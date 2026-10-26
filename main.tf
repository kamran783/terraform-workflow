terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket  = "tfstatefileforme" # Your exact bucket name
    key     = "devops-project/terraform.tfstate"
    region  = "ap-south-2" # Your Hyderabad region
    encrypt = true
  }

}

provider "aws" {
  region = "ap-south-2"
}



resource "aws_s3_bucket" "my_app_bucket" {
  bucket = "my-application-bucket-for-devops-job-12345" # Give this a unique name
}

