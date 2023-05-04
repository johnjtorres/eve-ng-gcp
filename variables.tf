variable "project" {
  description = "GCP project name"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "image_family" {
  description = "EVE-NG base image family"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "image_project" {
  description = "EVE-NG base image project"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "instance_name" {
  description = "Compute instance name"
  type        = string
  default     = "eve-ng"
}

variable "machine_type" {
  description = "Compute instance machine type"
  type        = string
}

variable "disk_size" {
  description = "Compute instance disk size"
  type        = number
}

variable "disk_type" {
  description = "Compute instance disk type"
  type        = string
  default     = "pd-ssd"
}

variable "service_account" {
  description = "Service account email"
  type        = string
}
