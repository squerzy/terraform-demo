resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.deployer.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.allow_web.id]

  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1>Instance ${var.env}. I am deployed with Infrastructure as Code</h1>" | sudo tee /var/www/html/index.nginx-debian.html
  EOF

  tags = {
    Name = "demo-${var.env}"
  }
}


