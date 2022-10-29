
resource "aws_apprunner_observability_configuration" "observability" {
  observability_configuration_name = "apprunner_observability"

  trace_configuration {
    vendor = "AWSXRAY"
  }
}

resource "aws_apprunner_auto_scaling_configuration_version" "scaling" {
  auto_scaling_configuration_name = "auto_scaling"

  min_size        = 1
  max_size        = 12
  max_concurrency = 80
}

resource "aws_apprunner_service" "apprunner" {
  service_name = "technical_test_2"

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.scaling.arn

  observability_configuration {
    observability_enabled           = true
    observability_configuration_arn = aws_apprunner_observability_configuration.observability.arn
  }

  source_configuration {
    image_repository {
      image_configuration {
        port = "8080"
      }

      image_identifier      = "public.ecr.aws/aws-containers/hello-app-runner:latest"
      image_repository_type = "ECR_PUBLIC"
    }
    auto_deployments_enabled = false
  }

  tags = {
    Name = "technical_test_2"
  }
}
