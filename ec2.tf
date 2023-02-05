resource "aws_instance" "jenkins" {
  ami             = "ami-0aa7d40eeae50c9a9"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.jenkins-sg.name]
  key_name        = "jenkins-key"
  provisioner "remote-exec" {
    inline = [
      "sudo yum update –y",
      "sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo",
      "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
      "sudo yum upgrade -y",
      "sudo amazon-linux-extras install java-openjdk11 -y",
      "sudo yum install jenkins -y",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins",
      "sudo systemctl status jenkins",
      "sudo yum install java-1.8.0-openjdk.x86_64 -y",
      "sudo yum install git -y",
      "sudo yum install maven -y",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("/home/ubuntu/jenkins-key.pem")
  }
  tags = {
    "Name" = "Jenkins"
  }
}