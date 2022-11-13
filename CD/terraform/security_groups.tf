
resource "aws_security_group" "sgr-rds" {
  name        = "${var.stack}-sgr-rds"
  description = "Allow mysql Private Subnet"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.stack}-sgr-rds"
  }
}

resource "aws_security_group_rule" "mysql-ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.sgr-rds.id
  cidr_blocks       = ["${var.vpc_cidr}"]
}
resource "aws_security_group_rule" "mysql-egress" {
  type              = "egress"
  from_port         = 1150
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${var.vpc_cidr}"]
  security_group_id = aws_security_group.sgr-rds.id
}

resource "aws_security_group" "sgr-web" {
  name        = "${var.stack}-sgr-web"
  description = "Allow Interner http and https"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "${var.stack}-sgr-web"
  }
}
resource "aws_security_group_rule" "web-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sgr-web.id
}
resource "aws_security_group_rule" "web-https-ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sgr-web.id
}
resource "aws_security_group_rule" "web-https-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sgr-web.id
}
