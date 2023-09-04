resource "aws_instance" "jenkins" {
  ami                         = var.ami
  instance_type               = "t2.small"
  subnet_id                   = "subnet-0552f9c9a440695b3"
  vpc_security_group_ids      = [aws_security_group.sg_yudin.id]
  associate_public_ip_address = true
  key_name                    = "dos-13-Anton_Yudin-lesson_39"

  provisioner "file" {
    source      = "/home/vagrant/diplom/Diplom"
    destination = "/home/ubuntu/Diplom/"
  }

  provisioner "file" {
    source      = "/home/vagrant/.ssh/id_rsa"
    destination = "/home/ubuntu/.ssh/id_rsa"
  }

  provisioner "file" {
    source      = "/home/vagrant/.aws"
    destination = "/home/ubuntu/.aws/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/Diplom/jenkins/credantion/script_install_for_ubuntu.sh",
      "chmod +x /home/ubuntu/Diplom/jenkins/credantion/ip_nginx.sh",
      "/home/ubuntu/Diplom/jenkins/credantion/script_install_for_ubuntu.sh", 
      "/home/ubuntu/Diplom/jenkins/credantion/ip_nginx.sh", 
    ]
  }


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("dos-13-Anton_Yudin-lesson_39.pem")
    host        = aws_instance.jenkins.public_ip
  }

  tags = {
    Name = "dos-13_Yudin-Anton_Jenkins"
  }
  depends_on = [aws_instance.nginx]
}
