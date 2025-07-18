# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_s3_to_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Policy for Lambda to access S3 and write logs
resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_s3_access_policy"
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "${var.source_bucket_arn}/uploads/*",         # source objects
          "${var.destination_bucket_arn}/uploads-bw/*"       # destination bucket
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Lambda Function
resource "aws_lambda_function" "bw_converter" {
  filename         = "${path.module}/python/python.zip"
  function_name    = "black_white_converter"
  handler          = "python.lambda_handler"
  runtime          = "python3.8"
  role             = aws_iam_role.lambda_exec.arn
  memory_size      = 128

  environment {
    variables = {
      DEST_BUCKET = var.destination_bucket_name
    }
  }
}

# Allow S3 to invoke Lambda
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.bw_converter.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.source_bucket_arn  # Your source bucket
}

# S3 Trigger Notification on object upload to /uploads/
resource "aws_s3_bucket_notification" "image_upload_trigger" {
  bucket = var.source_bucket_name  # Source bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.bw_converter.arn
    events              = ["s3:ObjectCreated:Put"]
    filter_prefix       = "uploads/"
    # filter_suffix     = ".jpg"  # Optional if you only want jpg
  }

  depends_on = [aws_lambda_permission.allow_s3]
}
