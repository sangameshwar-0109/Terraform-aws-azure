# this is for creation of vpc and subnets in aws 

resource "aws_vpc" "primary_network" {
  cidr_block = var.vpc_cidr
  tags = {
    name        = "ntier"
    Environment = "dev"
    createdBy   = "Terraform"
  }
}
# this is for creating subnets using reusable template with "count"

resource "aws_subnet" "subnets" {
  count      = var.subnetcount
  vpc_id     = aws_vpc.primary_network.id
  cidr_block = var.subnet_cidrs[count.index]

}