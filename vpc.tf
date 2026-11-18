# provider.tf
provider "aws" {
  region = "af-south-1"
}

# main.tf
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "my-custom-vpc"
  cidr = "10.0.0.0/16"

  # Distribute across two Availability Zones
  azs             = ["af-south-1a", "af-south-1b", "af-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  # Enable outbound internet access for private subnets via NAT Gateway
  enable_nat_gateway = true
  single_nat_gateway = true # Saves costs by using 1 NAT Gateway instead of 2

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
