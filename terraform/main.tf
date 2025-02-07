provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Use latest Amazon Linux AMI
  instance_type = "t2.micro"
  key_name      = "your-key-pair"
  security_groups = ["default"]
  
  tags = {
    Name = "Jenkins-Provisioned-EC2"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
