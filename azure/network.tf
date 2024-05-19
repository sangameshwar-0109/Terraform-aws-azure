resource "azurerm_resource_group" "ntier" {
  name     = "ntier"
  location = "eastus"

}

resource "azurerm_virtual_network" "primary" {
  name                = "primary"
  location            = "eastus"
  resource_group_name = "azurerm_resource_group.ntier.name"
  address_space       = ["192.168.0.0/16"]

}



resource "azurerm_network_security_group" "webnsg" {
  name                = "webnsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.ntier.name
  depends_on          = [azurerm_virtual_network.primary]

}

resource "azurerm_network_security_rule" "web_rules" {
  count                       = length(var.webnsg_rules_info)
  name                        = var.webnsg_rules_info[count.index].name
  resource_group_name         = azurerm_resource_group.ntier.name
  network_security_group_name = "webnsg"
  protocol                    = var.webnsg_rules_info[count.index].protocol
  source_port_range           = var.webnsg_rules_info[count.index].source_port_range
  destination_port_range      = var.webnsg_rules_info[count.index].destination_port_range
  direction                   = var.webnsg_rules_info[count.index].direction
  source_address_prefix       = var.webnsg_rules_info[count.index].source_address_prefix
  destination_address_prefix  = var.webnsg_rules_info[count.index].destination_address_prefix
  access                      = var.webnsg_rules_info[count.index].access
  priority                    = var.webnsg_rules_info[count.index].priority
  depends_on                  = [azurerm_network_security_group.webnsg]

}