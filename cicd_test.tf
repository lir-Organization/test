resource "azurerm_managed_disk" "source" {
  encryption_settings {
    enabled = false
  }
  create_option        = ""
  location             = ""
  name                 = ""
  resource_group_name  = "foo3"
  storage_account_type = ""
}