variable "vpc_id" {
  description = "VPC ID"
}

variable "properties" {
    type = map
}

variable "keys" {
    type = map
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to apply"
  default     = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}