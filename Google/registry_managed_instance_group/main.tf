// Google Cloud provider
provider "google" {
  version = "~> 1.5"
}
variable "mig_port_name" {
  description = ""
  default = ""
}

variable "mig_name" {
  description = ""
  default = ""
}

variable "mig_size" {
  description = ""
  default = ""
}

variable "mig_port" {
  description = ""
  default = ""
}

module "mig" {
  source            = "GoogleCloudPlatform/managed-instance-group/google"
  name              = "${var.mig_name}"
  size              = "${var.mig_size}"
  service_port      = "${var.mig_port}"
  service_port_name = "${var.mig_port_name}"
}

output "Instances" {
  value = "${module.mig.instances}"
}

output "Health_Check" {
  value = "${module.mig.health_check}"
}