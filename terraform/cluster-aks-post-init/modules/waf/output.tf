output "kubesubnet_id" {
    value = "${data.azurerm_subnet.kubesubnet.id}"
}
output "location" {
    value = "${azurerm_resource_group.k8s.location}"
}

output "rg-name" {
    value = "${azurerm_resource_group.k8s.name}"
}

output "ip-address" {
    value = "${azurerm_public_ip.publicip.ip_address}"
}
