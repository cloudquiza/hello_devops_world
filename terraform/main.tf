resource "aws_instance" "hello_devops_instance" {
  ami           = "ami-0c02fb55956c7d316"  # Replace with a valid Amazon Linux AMI ID for your region
  instance_type = "t2.micro"
  
  # Add the key pair for SSH access
  key_name = "my-key-pair"  # Replace with the name of the key pair you created in AWS

  # Set up the instance with Docker
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker",
      "sudo service docker start",
      # Use the access token from an environment variable
      "echo '${var.dockerhub_access_token}' | sudo docker login -u cloudquiza --password-stdin",
      # Pull the image from Docker Hub
    "sudo docker pull cloudquiza/hello-devops-world:latest",
    # Run the Docker image
    "sudo docker run cloudquiza/hello-devops-world:latest"
    ]
    # Connection block to specify how to connect to the instance
    connection {
      type        = "ssh"
      user        = "ec2-user"  # Default user for Amazon Linux AMI
      private_key = file("~/.ssh/my-key-pair.pem")  # Path to your private key
      host        = self.public_ip
    }
  }

  # Add a tag to the instance
  tags = {
    Name = "HelloDevOpsWorldInstance"
  }
}

# Define a Terraform variable to hold the Docker Hub access token
variable "dockerhub_access_token" {
  description = "Docker Hub access token for secure login"
  default     = ""
}

# Add the output block to display the instance state
output "instance_state" {
  value = aws_instance.hello_devops_instance.instance_state
}
