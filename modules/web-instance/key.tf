

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key-${var.env}"
  public_key = file("id_rsa.pub")
  tags = {
    Name = "demo-key-${var.env}"
  }
}