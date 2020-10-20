locals {
  #EC2 Info
  ami-id                = "ami-038e35de01603d84e"
  instance-type         = "t2.micro"
  keypair-name          = "nova-mp-kp"
  security-group-name   = "nova-mwp-k8s"
  subnet-name           = "nova-vpc-test-private-01-use1"
  ec2-tags              = {
      owner         = "mwpreston"
      environment   = "test"
      usecase       = "rds-demo-clothing-store"
      createdby     = "terraform"
      Name          = "eStore-Web"
  }
  #RDS Info
  rds-database-name         = "eStoreDB"
  rds-identifier            = "estoredb"
  rds-user                  = "dbuser"
  rds-pass                  = "SuperSecret123!2020"
}