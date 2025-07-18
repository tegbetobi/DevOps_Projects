# variable "region" {
#   default     = "us-east-1"
#   description = "AWS Region to deploy to"
# }


variable "aws_region" {
  default = "us-east-1"
}

variable "source_bucket_name" {
  default = "mini-project234"
  type        = string
}

variable "source_bucket_arn" {
  default = "arn:aws:s3:::mini-project234"
  type        = string
}

variable "destination_bucket_name" {
  default = "mini-project234-processed"
  type        = string
}

variable "destination_bucket_arn" {
  default = "arn:aws:s3:::mini-project234-processed"
  type        = string
}
