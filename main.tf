provider "aws" {
  region = "eu-central-1"
}

variable "cidr_blocks" {
  description = "cidr blocks and name tags for vpc and subnets"
  type = list(object({
    cidr_block = string
    name = string
  }))
}
variable "avail_zone" {}

resource "aws_vpc" "development-aws_vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name: var.cidr_blocks[0].name
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-aws_vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = var.cidr_blocks[1].name
  }
}

output "dev-vpc_id" {
  value = aws_vpc.development-aws_vpc.id
}

output "dev-subnet_id" {
  value = aws_subnet.dev-subnet-1.id
}