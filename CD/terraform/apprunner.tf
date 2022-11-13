
resource "aws_apprunner_observability_configuration" "observability" {
  observability_configuration_name = "apprunner_observability"

  trace_configuration {
    vendor = "AWSXRAY"
  }
}

resource "aws_apprunner_auto_scaling_configuration_version" "scaling" {
  auto_scaling_configuration_name = "auto_scaling"

  min_size        = var.min_size
  max_size        = var.max_size
  max_concurrency = var.max_concurrency
}

resource "aws_apprunner_service" "service" {
  service_name                   = "${var.stack}-apprunner"
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.scaling.arn

  observability_configuration {
    observability_enabled           = true
    observability_configuration_arn = aws_apprunner_observability_configuration.observability.arn
  }

  source_configuration {
    authentication_configuration {
      access_role_arn = aws_iam_role.apprunner-service-role.arn
    }
    image_repository {
      image_configuration {
        port = var.expose_port
        runtime_environment_variables = {
          DATABASE_DB_NAME       = "${var.db_name}",
          DATABASE_USER_NAME     = "${var.db_user}",
          DATABASE_USER_PASSWORD = "${var.db_password}",
          DATABASE_ENDPOINT      = "${aws_db_instance.db.address}"
        }
      }

      #image_identifier      = "${data.aws_ecr_repository.image_repo.repository_url}:latest"
      image_identifier      = "199920436475.dkr.ecr.us-east-1.amazonaws.com/lhstt2:latest"
      image_repository_type = "ECR"
    }
    auto_deployments_enabled = false
  }

  instance_configuration {
    instance_role_arn = aws_iam_role.apprunner-instance-role.arn
  }

  network_configuration {
    egress_configuration {
      egress_type       = "VPC"
      vpc_connector_arn = aws_apprunner_vpc_connector.connector.arn
    }
  }

  tags = {
    Name = "${var.stack}-service"
  }
  depends_on = [aws_db_instance.db, aws_route_table.private_route_table]
}

resource "aws_apprunner_vpc_connector" "connector" {
  vpc_connector_name = "vpc_connector"
  subnets            = aws_subnet.private.*.id
  security_groups    = [aws_security_group.sgr-web.id, aws_security_group.sgr-rds.id]
}
