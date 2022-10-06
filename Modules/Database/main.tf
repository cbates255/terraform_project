
resource "aws_db_instance" "DBinstance" {
  db_name              = var.db_name
  engine               = var.db_engine
  instance_class       = var.db_instanceclass
  username             = var.db_name
  password             = var.dbpass
  availability_zone    = var.zone1
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.dbsubgroup.name
}

resource "aws_db_subnet_group" "dbsubgroup" {
  subnet_ids = [var.privsubid]
}

resource "aws_db_security_group" "dbsecgroup" {
  name = "dbsecgroup"

  ingress {
    security_group_id = var.securitygroup
  }
}