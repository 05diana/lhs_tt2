resource "aws_db_subnet_group" "db-subnet-grp" {
  name        = "${var.stack}-db-subnet-grp"
  description = "Database Subnet Group"
  subnet_ids  = aws_subnet.private.*.id
  #subnet_ids  = aws_subnet.public.*.id
}

resource "aws_db_instance" "db" {
  #publicly_accessible         = true
  publicly_accessible             = false
  identifier                      = "lhstt2"
  engine                          = "mysql"
  port                            = "3306"
  instance_class                  = var.db_instance_class
  multi_az                        = false
  availability_zone               = "${var.aws_region}a"
  vpc_security_group_ids          = [aws_security_group.sgr-rds.id]
  db_subnet_group_name            = aws_db_subnet_group.db-subnet-grp.name
  allocated_storage               = var.db_storage
  storage_type                    = "gp2"
  apply_immediately               = true
  username                        = var.db_user
  db_name                         = var.db_name
  password                        = var.db_password
  skip_final_snapshot             = true
  backup_retention_period         = 0
  final_snapshot_identifier       = "Ignore"
  allow_major_version_upgrade     = true
  auto_minor_version_upgrade      = true
  #monitoring_interval             = 15
  #enabled_cloudwatch_logs_exports = ["error", "general"]

  tags = {
    Name = "${var.stack}-db"
  }
}
