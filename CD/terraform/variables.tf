variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "stack" {
  description = "Name of Stack"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
}

variable "az_numbers" {
  description = "Number to AZ in use to project"
}

variable "max_concurrency" {
  description = "Max Instances Concurrency"
}

variable "max_size" {
  description = "Max Instances size"
}

variable "min_size" {
  description = "Min Instances size"
}

variable "expose_port" {
  description = "Port app"
}

variable "db_instance_class" {
  description = "RDS Instance class definition"
}

variable "db_storage" {
  description = "DB Storage Size"
}

variable "db_name" {
  description = "Instance DB Name"
}

variable "db_user" {
  description = "Instance User Name"
}

variable "db_password" {
  description = "Instance User Password"
}

variable "image_repo_name" {
  description = "Repo Name"
}

variable "apprunner-service-role" {
  description = "Service Role"
}

variable "public_key" {
  description = "SSH Publicl Key"
}

