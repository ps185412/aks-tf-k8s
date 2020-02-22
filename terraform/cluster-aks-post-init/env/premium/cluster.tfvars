#--------------------------------------------------------------
# Cluster common
#--------------------------------------------------------------
agent_count             = 3
vm_size                 = "Standard_F8s_v2"
k8s_version             = "1.15.7"
os_disk_size_gb         = "30"
instance                = "premium"
environment             = "premium"
#--------------------------------------------------------------
# DNS-Zone
#--------------------------------------------------------------
#dns_a_record_names      = ["dev"]
#dns_zone_name           = "example.com"
#dns_zone_rg_name        = "dns-zone-rg"
#--------------------------------------------------------------
# WAF Backend Address Pool ip-address
#--------------------------------------------------------------
 backend_address_pool_ip_addresses = "15.0.0.25"
# --------------------------------------------------------------------------------
# Kubernetes Storage
# --------------------------------------------------------------------------------
storage_account_name    = "tfk8svolumestorage"