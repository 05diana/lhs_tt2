
resource "aws_apprunner_service" "apprunner" {
  service_name = "technical_test_2"

  source_configuration {
    image_repository {
      image_configuration {
        port = "8080"
      }

      image_identifier      = "public.ecr.aws/m4v5e2y2/apps:latest"
      image_repository_type = "ECR_PUBLIC"
    }
    auto_deployments_enabled = false
  }

  tags = {
    Name = "technical_test_2"
  }
}
