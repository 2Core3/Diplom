resource "aws_instance" "monitoring" {
  ami                         = var.ami
  instance_type               = "t2.small"
  subnet_id                   = "subnet-0552f9c9a440695b3"
  vpc_security_group_ids      = [aws_security_group.sg_yudin.id]
  associate_public_ip_address = true
  key_name                    = "dos-13-Anton_Yudin-lesson_39" 

  provisioner "file" {
    source      = "/home/vagrant/diplom/Diplom/monitoring"
    destination = "/home/ubuntu/monitoring/"
  }
  
  provisioner "file" {
    source      = "/home/vagrant/diplom/Diplom/jenkins/credantion"
    destination = "/home/ubuntu/credantion/"
  }

  provisioner "file" {
    source      = "/home/vagrant/.aws"
    destination = "/home/ubuntu/.aws/"
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/monitoring/script_install_monitoring.sh",
      "/home/ubuntu/monitoring/script_install_monitoring.sh",    
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("dos-13-Anton_Yudin-lesson_39.pem")
    host        = aws_instance.monitoring.public_ip
  } 

  tags = {
    Name = "dos-13_Yudin-Anton_Monitoring"
  }
  depends_on = [aws_instance.nginx, aws_instance.jenkins]
}
