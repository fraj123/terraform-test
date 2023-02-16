variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "profile" {
  description = "AWS Account Profile"
  type        = string
}

variable "cluster_name" {
  description = "Cluster Name"
  type = string
}
