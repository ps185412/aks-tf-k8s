variable "tags" {
  type = "map"

  default = {
    source = "terraform"
  }
}

variable "resource_group_name" {
  description = "Name of the resource group already created."
}

variable "location" {
  description = "Location of the cluster."
}

variable "app_gateway_name" {
  description = "Name of the Application Gateway."
  default = "ApplicationGateway"
}

variable "app_gateway_sku" {
  description = "Name of the Application Gateway SKU."
  default = "WAF_v2"
}


variable "app_gateway_tier" {
  description = "Tier of the Application Gateway SKU."
  default = "WAF_v2"
}

variable "virtual_network_name" {
  description = "Virtual network name"
  default     = "aksVirtualNetwork"
}

variable "virtual_network_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "15.0.0.0/8"
}

variable "aks_subnet_name" {
  description = "AKS Subnet Name."
  default     = "kubesubnet"
}

variable "aks_subnet_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "15.0.0.0/16"
}

variable "app_gateway_subnet_address_prefix" {
  description = "Containers DNS server IP address."
  default     = "15.1.0.0/16"
}

variable "ssl_certificate_value" {
  description = "The value of the certificate"
}

variable "ssl_certificate_pwd" {
  description = "password for the ssl certificate"
}

variable "probe_status_code" {
  description = "istio gateway probe status code. ( False positive for standard cluster)"
}
variable "backend_address_pool_ip_addresses" {
  description = "ip addresses of the backend pool, kubernetes internal ip as assign by istio"
}

