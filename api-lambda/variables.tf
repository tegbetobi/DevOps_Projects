variable "api_name" {
  description = "Name of the API"
  #type        = string
  default     = "terraform_api_2006"
}

variable "stage" {  
  description = "dev"
  default     = "dev"
}

variable "lambda_function_name" {
  description = "terraform_api_lambda_2006"
  default     = "terraform_api_lambda_2006"
}

variable "lambda_role" {
  description = "lambda_role_2006"
  default     = "lambda_role_2006"
}