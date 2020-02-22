resource "null_resource" "provision" {
  triggers = {
    trigger = "${uuid()}"
  }
  
  # Restrict the credentials to Azure AD user.
  provisioner "local-exec" {
    command = "az aks get-credentials --overwrite-existing --resource-group ${var.azurerm_resource_group_k8s_name} --name ${var.azurerm_kubernetes_cluster_k8s_name} --admin"
  }

  # Install Helm 3
  provisioner "local-exec" {   
    command = "../../init-scripts/install-helm.sh ; ./get_helm.sh"
  }
}