resource "azurerm_resource_group""batcha06"{
    name="batch_A06_Resource_Group"
    location="Canada Central"   
}

resource "azurerm_virtual_network" "mcitnetwork" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.batcha06.name
  location            = azurerm_resource_group.batcha06.location
}
resource "azurerm_subnet" "mcitinternal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.batcha06.name
  virtual_network_name = azurerm_virtual_network.mcitnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_interface" "mcitnic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.batcha06.location
  resource_group_name = azurerm_resource_group.batcha06.name

  ip_configuration {
    name                          = "mcit ip configuration"
    subnet_id                     = azurerm_subnet.mcitinternal.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "azurermvm" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.batcha06.location
  resource_group_name   = azurerm_resource_group.batcha06.name
  network_interface_ids = [azurerm_network_interface.mcitnic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}
