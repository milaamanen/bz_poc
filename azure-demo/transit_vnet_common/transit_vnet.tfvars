location             = "West Europe"
resource_group_name  = "bzpoc-vmseries-rg-vms"
virtual_network_name = "bzpoc-vnet-vmseries"
address_space        = ["10.110.0.0/16"]
enable_zones         = true
tags                 = { environment = "bzpoc" }

network_security_groups = {
  "bzpoc-sg-mgmt"    = {}
  "bzpoc-sg-private" = {}
  "bzpoc-sg-public"  = {}
}

allow_inbound_mgmt_ips = [
  "134.238.43.11", # Put your own public IP address here
  "20.224.220.48",   # Example Panorama access
  "84.207.227.14"
]

olb_private_ip = "10.110.0.21"

route_tables = {
  private_route_table = {
    routes = {
      default = {
        address_prefix         = "0.0.0.0/0"
        next_hop_type          = "VirtualAppliance"
        next_hop_in_ip_address = "10.110.0.21"
      }
    }
  }
}

subnets = {
  "subnet-mgmt" = {
    address_prefixes       = ["10.110.255.0/24"]
    network_security_group = "bzpoc-sg-mgmt"
  }
  "subnet-private" = {
    address_prefixes       = ["10.110.0.0/24"]
    network_security_group = "bzpoc-sg-private"
    route_table            = "private_route_table"
  }
  "subnet-public" = {
    address_prefixes       = ["10.110.129.0/24"]
    network_security_group = "bzpoc-sg-public"
  }
}

frontend_ips = {
  "frontend01" = {
    create_public_ip = true
    rules = {
      "balancessh" = {
        protocol = "Tcp"
        port     = 22
      }
    }
  }
}

vmseries = {
  "fw00" = { avzone = 1 }
  "fw01" = { avzone = 2 }
  "fw02" = { avzone = 3 }
}

common_vmseries_version = "10.1.5"
common_vmseries_sku     = "byol"
storage_account_name    = "bzpocpantfstorage"
storage_share_name      = "bzpocbootstrapshare"

files = {
  "files/authcodes"    = "license/authcodes" # authcode is required only with common_vmseries_sku = "byol"
  "files/init-cfg.txt" = "config/init-cfg.txt"
}
