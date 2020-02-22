data "azurerm_resource_group" "dns_zone" {
  name     = "${var.dns_zone_rg_name}"
}

data "azurerm_dns_zone" "dns_zone" {
  name                = "${var.dns_zone_name}"
  resource_group_name = "${data.azurerm_resource_group.dns_zone.name}"
}

resource "azurerm_dns_a_record" "dns_zone" {
  name                = "${var.dns_a_record_names[count.index]}"
  zone_name           = "${data.azurerm_dns_zone.dns_zone.name}"
  resource_group_name = "${data.azurerm_resource_group.dns_zone.name}"
  ttl                 = 3600
  records             = ["${var.ag_public_ip}"]
  count               = length("${var.dns_a_record_names}")
}