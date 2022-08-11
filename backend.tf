terraform {
  backend "s3" {
    bucket         = "talent-academy-manojkudla-lab-tfstate"
    key            = "talent-academy/project-ec2/terraform.tfstates"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
  }
}