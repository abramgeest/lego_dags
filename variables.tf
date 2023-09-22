# variable "name" {
#   description = "Name of MWAA Environment"
#   default     = "terraform-mwaa"
#   type        = string
# }

# variable "region" {
#   description = "region"
#   type        = string
#   default     = "us-east-2"
# }

# # variable "tags" {
# #   description = "Default tags"
# #   default     = {"env": "test", "dept": "AWS Developer Relations"}
# #   type        = map(string)
# # }

# variable "vpc_cidr" {
#   description = "VPC CIDR for MWAA"
#   type        = string
#   default     = "10.1.0.0/16"
# }

variable "tags" {
  type        = map(string)
  default     = {}
  description = "AWS Tags common to all the resources created"
}
