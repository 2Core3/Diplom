variable "region" {
    type    = string
    default = "us-east-1"
}

variable "ami" {
    type    = string
    default = "ami-0261755bbcb8c4a84"
}

variable "web" {
    type    = list
    default = ["22", "80", "8080", "3000", "9093", "9100", "9115", "9090", "2375", "50000"]
}
