variable "client_id" {}
variable "client_secret" {}

variable "ad_client_app_id" {}
variable "ad_server_app_id" {}
variable "ad_server_app_secret" {}

variable "enable_rbac" {
  description = "Enable RBAC true or false"
}

variable "agent_count" {
    description = "Number of VMs"
}

variable "vm_size" {
   description = "Standard Size of VM"
}

variable "k8s_version" {
   description = "Kubernetes Version"
}

variable "os_disk_size_gb" {
   description = "Disk Size in GB for Kubernetes"
}

variable "prefix" {
    description = "default prefix to use for resources."
}

variable "dns_prefix" {
    description = "default DNS prefix"
}

variable "vnet_subnet_id" {
    description = "vnet subnet id"
}

variable cluster_name {
    description = "Kubernetes cluster name"
}

variable "aks_service_cidr" {
  description = "A CIDR notation IP range from which to assign service cluster IPs."
  default     = "10.0.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "Containers DNS server IP address."
  default     = "10.0.0.10"
}

variable "aks_docker_bridge_cidr" {
  description = "A CIDR notation IP for Docker bridge."
  default     = "172.17.0.1/16"
}

variable resource_group_name {
    description = "Resource group for Kubernetes Cluster"
}

variable location {
   description = "Location of the Cloud Provider(Azure)"
}