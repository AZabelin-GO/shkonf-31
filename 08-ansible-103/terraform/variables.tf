variable "api_token" {
  type        = string
  sensitive   = true
  description = "API token for YandexCloud"
}

variable "cloud_id" {
  type        = string
  sensitive   = false
  description = "ID of the cloud for resources"
}

variable "folder_id" {
  type        = string
  sensitive   = false
  description = "ID of the folder for resources"
}

variable "default_zone" {
  type        = string
  sensitive   = false
  default     = "ru-central1-a"
  description = "Default availability zone for resources"
}
