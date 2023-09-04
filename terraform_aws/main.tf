provider "aws" {
  region = var.region
}

resource "aws_instance" "nginx" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-0552f9c9a440695b3"
  vpc_security_group_ids      = [aws_security_group.sg_yudin.id]
  associate_public_ip_address = true
  key_name                    = "dos-13-Anton_Yudin-lesson_39"

  provisioner "file" {
    source      = "/home/vagrant/diplom/Diplom/nginx/"
    destination = "/home/ubuntu/"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/script_install_docker_ubuntu_deploy.sh",
      "chmod +x /home/ubuntu/scripts_rm_and_push.sh",
      "/home/ubuntu/script_install_docker_ubuntu_deploy.sh", 
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("dos-13-Anton_Yudin-lesson_39.pem")
    host        = aws_instance.nginx.public_ip
  }

  tags = {
    Name = "dos-13_Yudin-Anton_Nginx"
  }
}
