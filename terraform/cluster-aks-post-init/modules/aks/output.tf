output "client_key" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.client_key}"
}

output "client_certificate" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate}"
}

output "cluster_username" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.username}"
}

output "cluster_password" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.password}"
}

output "cluster_name" {
    value = "${azurerm_kubernetes_cluster.k8s.name}"
}

output "host" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_config.0.host}"
}

output "kube_config" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_config_raw}"
}

output "name" {
    value = "${azurerm_kubernetes_cluster.k8s.name}"
}

output "admin_kube_config" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_admin_config_raw}"
}

output "admin_client_key" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_key}"
}

output "admin_client_certificate" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_admin_config.0.client_certificate}"
}

output "admin_cluster_ca_certificate" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_admin_config.0.cluster_ca_certificate}"
}

output "admin_cluster_username" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_admin_config.0.username}"
}

output "admin_cluster_password" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_admin_config.0.password}"
}

output "admin_host" {
    value = "${azurerm_kubernetes_cluster.k8s.kube_admin_config.0.host}"
}