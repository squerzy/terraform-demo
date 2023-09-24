module "web1" {
  source = "./modules/web-instance"
  env = "dev"
  vpc_id = aws_vpc.demo_vpc.id
  subnet_id = aws_subnet.demo_subnet_1a.id
}

output "web1_public_ip" {
  value = module.web1.public_ip
}

module "web2" {
  source = "./modules/web-instance"
  env = "stage"
  vpc_id = aws_vpc.demo_vpc.id
  subnet_id = aws_subnet.demo_subnet_1a.id
}

output "web2_public_ip" {
  value = module.web2.public_ip
}
