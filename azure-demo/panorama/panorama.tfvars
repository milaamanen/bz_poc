management_ips = {
  "82.181.197.31" : 100,
}

location             = "North Europe"
tags                 = { environment = "milaamanen-test" }
resource_group_name  = "milaamanen-panorama-rg"
vnet_name            = "milaamanen-panorama-vnet"
storage_account_name = "milaamanenpanoramastora"
enable_zones         = true
panorama_version     = "10.1.5"
