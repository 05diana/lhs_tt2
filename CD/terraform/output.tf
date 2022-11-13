
output "service_url" {
  value = "https://${aws_apprunner_service.service.service_url}"
}
