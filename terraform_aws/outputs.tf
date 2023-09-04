output "nginx" {
  value = "${aws_instance.nginx.public_ip}:80"
}

output "jenkins" {
  value = "${aws_instance.jenkins.public_ip}:8080"
}

output "grafana" {
  value = "${aws_instance.monitoring.public_ip}:3000"
}

output "prometheus" {
  value = "${aws_instance.monitoring.public_ip}:9090"
}