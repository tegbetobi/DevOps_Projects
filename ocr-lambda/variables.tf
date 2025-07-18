# variable "region" {
#   default     = "us-east-1"
#   description = "AWS Region to deploy to"
# }



variable "aws_region" {
  default = "us-east-1"
}

variable "s3_bucket_name" {
  default = "mini-project234"
  type        = string
}

variable "s3_bucket_arn" {
  default = "arn:aws:s3:::mini-project234"
  type        = string
}

variable "dynamodb_table_arn" {
  default = "arn:aws:dynamodb:us-east-1:672790302863:table/bild-test"
  type        = string
}
