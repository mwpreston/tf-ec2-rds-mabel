locals {
  #EC2 Info
  ec2-name              = "MabelOutlet-Web-Base"
  ami-id                = "ami-038e35de01603d84e"
  instance-type         = "t2.micro"
  keypair-name          = "nova-mp-kp"
  security-group-id     = "sg-0e86d78907c7c5f24"
  subnet-name           = "nova-vpc-test-private-01-use1"
  ec2-count             = "6"
  tags              = {
      owner         = "mwpreston"
      environment   = "dev"
      usecase       = "mabel-outlet-rds-ec2"
      createdby     = "terraform"
  }
  #DB Subnet Group Info
  dbsg-name = "nova-db-subnet-mabel"
  dbsg-ids = ["subnet-066f4b6b2fca11e90","subnet-023cbf85c55982d22"]

  #RDS Info
  rds-database-name         = "MabelOutletDB"
  rds-identifier            = "mabeloutletdb"
  rds-user                  = "dbuser"
  rds-pass                  = "SuperSecret123!2020"
}