resource "aws_security_group" "sg_yudin" {
  name              = "Security Group Yudin"
  description       = "SSH, monitoring, jenkins, nginx"
    dynamic "ingress" {
    for_each        = var.web
    content {
        from_port   = ingress.value
        to_port     = ingress.value
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]    
    }
    tags = {
        Name = "sg_yudin"
  }
}