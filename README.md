# Terraform Beispiel

Dieses Beispiel zeigt wie Terraform genutzt werden kann um Cloud Resourcen mit Infrastructure as code zu definieren und zu instanziieren.

## Voraussetzungen

- Installation der [AWS CLI](https://aws.amazon.com/cli/)
- Installation von [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Ausfuehren

```bash
# Erstellen eines Keyfiles fuer den SSH zugriff auf die Webserver
ssh-keygen -t rsa -N '' -f id_rsa

# Installieren von Terraform Modulen
terraform init

# Ausfuehren der Terraform Planung
terraform plan

# Erstellen der mit Terraform definierten Resourcen in der Cloud
terraform apply

# Aufruf der erzeugten Web Server
curl $(terraform output -raw web1_public_ip)
curl $(terraform output -raw web2_public_ip)
curl $(terraform output -raw web3_public_ip)

# Verbinden mit SSH
ssh -i ./id_rsa ubuntu@$(terraform output -raw web1_public_ip)
ssh -i ./id_rsa ubuntu@$(terraform output -raw web2_public_ip)
ssh -i ./id_rsa ubuntu@$(terraform output -raw web3_public_ip)

# Loeschen aller resourcen
terraform destory
```
