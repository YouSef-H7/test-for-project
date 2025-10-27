module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "acr" {
  source              = "./modules/ACR"
  resource_group_name = "error-team-rg"
  location            = var.location
  acr_name            = "acrteam4"
}

module "aks" {
  source              = "./modules/AKS"
  resource_group_name = var.resource_group_name
  location            = var.location
  cluster_name        = var.cluster_name

  vnet_subnet_id        = module.network.aks_subnet_id
  acr_id                = module.acr.acr_id
  app_gateway_id        = module.app_gateway.appgw_id
  app_gateway_subnet_id = module.network.appgw_subnet_id

  depends_on = [module.app_gateway]
}

module "app_gateway" {
  source              = "./modules/app_gateway"
  appgw_name          = "appgw-team4"
  location            = "germanywestcentral"
  resource_group_name = "error-team-rg"
  subnet_id           = module.network.appgw_subnet_id
}
