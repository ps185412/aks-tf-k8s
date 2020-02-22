# Create Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "k8s" {
    name                = "${var.cluster_name}"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    dns_prefix          = "${var.dns_prefix}"
    kubernetes_version  = "${var.k8s_version}"
    
    #RBAC
    role_based_access_control { 
       enabled                = "${var.enable_rbac}" 
       azure_active_directory {
            client_app_id     = "${var.ad_client_app_id}"
            server_app_id     = "${var.ad_server_app_id}"
            server_app_secret = "${var.ad_server_app_secret}"
       }
    } 

    # Provisioning Profile
    agent_pool_profile {
        name            = "default"
        count           = "${var.agent_count}"
        vm_size         = "${var.vm_size}"
        os_type         = "Linux"
        os_disk_size_gb = "${var.os_disk_size_gb}"
        vnet_subnet_id  = "${var.vnet_subnet_id}"
    }

    # Enable Analytics
    addon_profile {
        oms_agent {
            enabled                    = true
            log_analytics_workspace_id = "${azurerm_log_analytics_workspace.k8s.id}"
        } 
        http_application_routing {
      		enabled = false
    	} 
    }

    # Use Service principals
    service_principal {
        client_id     = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }   
    
    network_profile {
    	network_plugin     = "azure"
    	dns_service_ip     = "${var.aks_dns_service_ip}"
    	docker_bridge_cidr = "${var.aks_docker_bridge_cidr}"
    	service_cidr       = "${var.aks_service_cidr}"
  	}

    tags = {
        Environment = "Development"
    }
}
