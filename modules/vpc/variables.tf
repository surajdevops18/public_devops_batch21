variable "vpc_cidr" {
    description = "VPC CIDR Block"
    type =  string
  
}

variable "public_subnet_cidr" {
    description = "Public Subnet CIDR's"
    type =  list(string)
  
}

variable "private_subnet_cidr" {
    description = "Private Subnet CIDR's"
    type =  list(string)
  
}

variable "availability_zones" {
    description = "Availability Zones"
    type =  list(string)
  
}

variable "environment" {
    description = "Environment Name"
    type =  string
  
}




