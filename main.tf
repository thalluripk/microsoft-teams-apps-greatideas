terraform {
  
  backend azurerm {
    resource_group_name  = "thalluri-rg-group1"
    storage_account_name = "thalluristorageaccount1"
    container_name       = "greatideas-container"
    key                  = "dev-greatIdeas.tfstate"
    subscription_id      = "7ea56f79-1380-42bb-9d4a-98989c8e8422"
    tenant_id            = "4dd77da9-34d7-44e4-b224-9a8cc69a317c"
  }
}

provider azurerm {
  version = ">= 2.26"
  skip_provider_registration = true
  features {}
}

# Used to derive tenant id etc.
data azurerm_client_config current {}

# Target a resource group
data "azurerm_resource_group" "rg" {
  name = var.appResourceGroupName
}

data "azurerm_key_vault" "keyvault" {
  name                = var.azureKeyVaultName
  resource_group_name = var.azureKeyVaultResourceGroupName
}

data "azurerm_key_vault_secret" "secret" {
  name         = var.azureKeyVaultSecretName
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_template_deployment" "greatIdeasTemplate" {
  name                = "teams_greatidea_template"
  resource_group_name = data.azurerm_resource_group.rg.name
  template_body       = file("azuredeploy.json")

  # these key-value pairs are passed into the ARM Template's `parameters` block
  parameters = {
    "tenantId"         = var.tenantId
    "baseResourceName" = var.baseResourceName
    "appDisplayName"   = "Great Ideas"
    "appDescription"   = "Innovation"
    "botClientId"      = var.botClientId
    "botClientSecret"  = data.azurerm_key_vault_secret.secret.value
    "teamLink"         = var.teamLink
    "DefaultCulture"   = "en-US"
    "appIconUrl"       = "https://raw.githubusercontent.com/OfficeDev/microsoft-teams-company-communicator-app/master/Manifest/color.png"
    "gitRepoUrl"       = "https://github.com/thalluripk/microsoft-teams-apps-greatideas.git"
    "gitBranch"        = "master"
  }

  deployment_mode = "Incremental"

}

output "appDomain" {
  value = azurerm_template_deployment.greatIdeasTemplate.outputs["appDomain"]
}
