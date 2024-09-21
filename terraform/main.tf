resource "aws_security_group" "allow_ssh_and_http" {
  name_prefix = "hello-devops-allow-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere, secure this in production
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "hello_devops_instance" {
  ami           = "ami-0c02fb55956c7d316"  # Replace with a valid Amazon Linux AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "my-key-pair"  # Replace with the name of the key pair you created in AWS

  # Attach the security group
  vpc_security_group_ids = [aws_security_group.allow_ssh_and_http.id]

  provisioner "local-exec" {
    command = "sleep 30"  # Add a delay to ensure the instance is ready
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker",
      "sudo service docker start",
      "echo '${var.dockerhub_access_token}' | sudo docker login -u cloudquiza --password-stdin",
      "sudo docker pull cloudquiza/hello-devops-world:latest",
      "sudo docker run -d -p 80:80 cloudquiza/hello-devops-world:latest"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/my-key-pair.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "HelloDevOpsWorldInstance"
  }
}

variable "dockerhub_access_token" {
  description = "Docker Hub access token for secure login"
}

output "instance_state" {
  value = aws_instance.hello_devops_instance.instance_state
}
