resource "aws_s3_bucket" "example" {
  bucket = var.aws_s3_name

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.dynamo_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "ImageId"

  attribute {
    name = "ImageId"
    type = "S"
  }

  attribute {
    name = "Status"
    type = "S"
  }

  attribute {
    name = "Timestamp"
    type = "S"
  }



  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}