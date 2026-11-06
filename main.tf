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



resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
  tags = {
    Name = "MySubnet-${count.index}"
  }
}

resource "aws_instance" "instance" {
  ami           = "ami-0c24c764e44ed98f2"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet[0].id
  tags = {
    Name = "MyInstance"
  }
}
resource "aws_s3_bucket" "my_app_bucket" {
  bucket = "my-application-bucket-for-devops-job-12345678" # Give this a unique name
}

