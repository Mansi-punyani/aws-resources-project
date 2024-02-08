variable "aws_region" {
  description = "Default region"
  default     = "ap-south-1"
  validation {
    condition     = var.aws_region != ""
    error_message = "AWS Region must be defined."
  }
}

variable "environment" {
  description = "Environment"
  default     = "dev"
  validation {
    condition     = var.environment != ""
    error_message = "Environment name must be defined."
  }
}

variable "project" {
  description = "Project name (this is applied as a tag)"
  default     = "cogniwide-project"
  validation {
    condition     = var.project != ""
    error_message = "Project name must be defined."
  }
}