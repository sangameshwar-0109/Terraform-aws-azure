variable "region" {
  type        = string
  default     = "us-west-2"
  description = "region in which resource will be created"
}


variable "vpc_cidr" {
  type    = string
  default = "10.100.0.0/16"
}

variable "subnetcount" {
  type    = string
  default = 5

}

variable "subnet_cidrs" {
  type    = list(string)
  default = ["10.100.0.0/24", "10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24", "10.100.4.0/24"]
}