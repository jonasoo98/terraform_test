resource "azurerm_resource_group" "jonas_resource_group" {
  name     = "jonas_resource_group"
  location = "westeurope"
  tags = {
    "foo" : "bar69"
    "bar": "foo69"
  }
}


module "linuxservers" {
  source                        = "Azure/compute/azurerm"
  location                      = "westeurope"
  resource_group_name           = "jonas_resource_group"
  vm_os_simple                  = "UbuntuServer"
  public_ip_dns                 = ["jonasmeganicedns69"] // change to a unique name per datacenter region
  remote_port                   = 22
  ssh_key                       = "/home/jonasoo/.ssh/id_rsa"
  #ssh_key_values                = [var.ssh-public-key]
  delete_os_disk_on_termination = true
  vnet_subnet_id                = azurerm_subnet.jonas_subnet.id
  depends_on                    = [azurerm_resource_group.jonas_resource_group]
}

resource "azurerm_virtual_network" "jonas_vnet" {
  name                = "jonas_vnet"
  resource_group_name = "jonas_resource_group"
  address_space       = ["10.0.0.0/24"]
  location            = "westeurope"
  depends_on          = [azurerm_resource_group.jonas_resource_group]
}

resource "azurerm_subnet" "jonas_subnet" {
  name                 = "jonas_subnet"
  resource_group_name  = "jonas_resource_group"
  virtual_network_name = "jonas_vnet"
  address_prefixes     = ["10.0.0.0/26"]
  depends_on           = [azurerm_virtual_network.jonas_vnet, azurerm_resource_group.jonas_resource_group]
}
