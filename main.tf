#Create EC2 Innstance
data "aws_subnet" "subnet" {
  tags = {
    Name = local.subnet-name
  }
}

data "template_file" "userdata" {
    depends_on = [
        aws_db_instance.db
    ]
    template = file("files/wp-setup.sh")
    vars = {
        db_hostname = aws_db_instance.db.address
        db_user     = local.rds-user
        db_password = local.rds-pass
        db_name     = local.rds-database-name
    }
}

resource "aws_db_subnet_group" "dbs" {
  name    = local.dbsg-name
  subnet_ids = local.dbsg-ids
    tags = {
      Name = local.dbsg-name
  }
}
resource "aws_db_instance" "db" {
    depends_on = [
        aws_db_subnet_group.dbs
    ]
    identifier              = local.rds-identifier
    allocated_storage       = "20"
    storage_type            = "gp2"
    engine                  = "mysql"
    engine_version          = "5.7"
    instance_class          = "db.t2.micro"
    name                    = local.rds-database-name
    username                = local.rds-user
    password                = local.rds-pass
    parameter_group_name    = "default.mysql5.7"
    db_subnet_group_name    = aws_db_subnet_group.dbs.name
    vpc_security_group_ids  = [local.security-group-id]
    tags                    = local.rds-tags
}

resource "aws_instance" "ec2" {
  ami           = local.ami-id
  instance_type = "t2.micro"

  depends_on = [
    aws_db_instance.db,
  ]

  key_name                    = local.keypair-name
  vpc_security_group_ids      = [local.security-group-id]
  subnet_id                   = data.aws_subnet.subnet.id

  user_data = data.template_file.userdata.rendered

  tags = local.ec2-tags
}