# # Locals block for hardcoded names. 
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-bkendpool"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  https_frontend_port_name       = "${azurerm_virtual_network.vnet.name}-feporthttps"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-http-setting"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rule"

  app_gateway_subnet_name = "appgwsubnet"
}

# Resource
resource "azurerm_resource_group" "k8s" {
    name     = "${var.resource_group_name}"
    location = "${var.location}"
}

#Virtual Networks
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.virtual_network_name}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  location            = "${azurerm_resource_group.k8s.location}"
  address_space       = ["${var.virtual_network_address_prefix}"]

  subnet {
    name           = "${var.aks_subnet_name}"
    address_prefix = "${var.aks_subnet_address_prefix}" # Kubernetes Subnet Address prefix
  }

  subnet {
    name           = "appgwsubnet"                              # Has to be hardcoded to this name.
    address_prefix = "${var.app_gateway_subnet_address_prefix}"
  }

  tags = "${var.tags}"
}

data "azurerm_subnet" "kubesubnet" {
  name                 = "${var.aks_subnet_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
}

data "azurerm_subnet" "appgwsubnet" {
  name                 = "appgwsubnet"                            #Hardcoded to this name. 
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
}

# Public Ip 
resource "azurerm_public_ip" "publicip" {
  name                         = "gatewayIP"
  location                     = "${azurerm_resource_group.k8s.location}"
  resource_group_name          = "${azurerm_resource_group.k8s.name}"
  allocation_method            = "Static"
  sku                          = "Standard"

  tags = "${var.tags}"
}

resource "azurerm_application_gateway" "network" {
  name                = "${var.app_gateway_name}"
  resource_group_name = "${azurerm_resource_group.k8s.name}"
  location            = "${azurerm_resource_group.k8s.location}"

  sku {
    name     = "${var.app_gateway_sku}"
    tier     = "${var.app_gateway_tier}"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = "${data.azurerm_subnet.appgwsubnet.id}"
  }


  frontend_port {
    name = "${azurerm_virtual_network.vnet.name}-feport"
    port = 80 
  }
  frontend_port {
    name = "${azurerm_virtual_network.vnet.name}-feport443"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${azurerm_public_ip.publicip.id}"
  }

  backend_address_pool {
    name = "${local.backend_address_pool_name}"
    ip_addresses = ["${var.backend_address_pool_ip_addresses}"]
  }

  backend_http_settings {
    name                                = "${local.http_setting_name}"
    cookie_based_affinity               = "Disabled"
    port                                = 80
    protocol                            = "Http"
    request_timeout                     = 1
    pick_host_name_from_backend_address = true
    probe_name                          = "gateway"
  }


    http_listener {
      name                           = "${azurerm_virtual_network.vnet.name}-httplstn1"
      frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
      frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
      protocol                       = "http"
      ssl_certificate_name           = "default"
    }

  http_listener {
    name                           = "${azurerm_virtual_network.vnet.name}-httpslstn1"
    frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
    frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport443"
    protocol                       = "https"
    ssl_certificate_name           = "default"
  }

  # Provide the certificate from the local path.
  ssl_certificate {
    name     = "default"
    data     = "${ filebase64("../../init-scripts/files/certs/cert.pfx" ) }"
    password = "${var.ssl_certificate_pwd}"
  }

  request_routing_rule {
    name                       = "${local.request_routing_rule_name}"
    rule_type                  = "Basic"
    http_listener_name         = "${azurerm_virtual_network.vnet.name}-httpslstn1"
    backend_address_pool_name  = "${local.backend_address_pool_name}"
    backend_http_settings_name = "${local.http_setting_name}"
  }

  tags = "${var.tags}"

  probe {
      interval                                  = 30
      minimum_servers                           = 0 
      name                                      = "gateway" 
      path                                      = "/foo"
      pick_host_name_from_backend_http_settings = true 
      protocol                                  = "Http"
      timeout                                   = 30 
      unhealthy_threshold                       = 3 
            match {
                status_code = [
                    "${var.probe_status_code}",
                  ] 
            }
  }

  waf_configuration {
     enabled                  = true 
     file_upload_limit_mb     = 100 
     firewall_mode            = "Detection" 
     max_request_body_size_kb = 128 
     request_body_check       = false 
     rule_set_type            = "OWASP"
     rule_set_version         = "3.0" 
  }

  depends_on = [ "azurerm_virtual_network.vnet", "azurerm_public_ip.publicip"]
  }


