variable "resource_group" {
  description = "The name of the resource group in which to create the virtual network."
  default     = "tf-dcs-k8s-rg"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default     = "West Europe"
}

variable "instance" {
  description = "DNS-compatible Instance Name"
}

variable "environment" {
  description = "DNS-compatible Environment Name (dev, stag, prod)"
}

variable "agent_count" {
   description = "Number of Cluster Agent Nodes (GPU Quota is defaulted to only 1 Standard_NC6 per subscription) - Please view https://docs.microsoft.com/en-us/azure/aks/faq#are-security-updates-applied-to-aks-agent-nodes"
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


variable "dns_a_record_names" {
  description = "DNS A-records for a given cluster type"
 }

variable "dns_zone_name" {
 description = "public DNS Zone from Azure"
 default     = "bosch-mns.com"
}

variable "dns_zone_rg_name" {
 description = "Resource Group of DNS zone"
}

variable "backend_address_pool_ip_addresses" {
  description = "ip addresses of the backend pool, kubernetes internal ip as assign by istio"
  default     = "10.0.0.0"
}

variable "storage_account_name" {
  default = "tfk8svolumestorage"
}

variable "cluster_specific_probe_status_code" {
  description = "Cluster specific probe status code for application gateway."
  default     = "200-399"
}
