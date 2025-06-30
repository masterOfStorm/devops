#set provider
provider "aws" {
	region = "ap-south-1"
}

# set a security group (allow port 80 to be exposed, block outbound)
resource "aws_security_group" "web_sg" {
	name = "web_sg"
	description = "Allow HTTP inbound traffic"
	ingress {
		description = "HTTP"
		from_port = 80
		to_port = 80
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

# Create an EC2 machine to handle the webserver
resource "aws_instance" "web_server" {
	ami = "ami-0d03cb826412c6b0f"
	instance_type = "t2.micro"
	security_groups = [aws_security_group.web_sg.name]
	
	#BASH commands to run ON THE SERVER
	user_data = <<-EOF
		#!/bin/bash
		yum update -y
		yum install -y httpd
		systemctl start httpd
		systemctl enable httpd
		echo "<h1>Deployed via Terraform</h1>" > /var/www/html/index.html
		EOF
		
	tags = {
		Name = "TerraformWebServer"
	}
}