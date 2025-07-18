variable "aws_region" {
  default = "us-east-1"
}

variable "aws_s3_name" {
  description = "Name of the bucket"
  #type        = string
  default     = "s3-bild-craft"
}

variable "dynamo_name" {
  description = "name of dynamo db"
  default     = "dynamo-bild-craft"
}