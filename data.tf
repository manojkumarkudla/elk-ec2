data "aws_vpc" "main_vpc" {
  filter {
    name   = "tag:Name"
    values = ["main-vpc"]
  }
}
data "aws_subnet" "public_subnet1" {
  filter {
    name   = "tag:Name"
    values = ["public-subnet1"]
   }

}
data "aws_subnet" "private_subnet1" {
  filter {
    name   = "tag:Name"
    values = ["private-subnet1"]
   }

}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }


  owners = ["099720109477"] # Canonical
}
