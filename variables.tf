variable tenantId {
  type = string
   description = "The tenant ID of the registered communicator app."
}

variable subscriptionId {
  type = string
   description = "Subscription Id"
}

variable storageResourceGroupName {
  type = string
   description = "Storage Resource Group Name"
}

 variable storageAccount {
  type = string
   description = "Storage Account"
}

variable storageContainerName {
  type = string
   description = "Storage Container Name"
}

variable terrafromStateKey {
  type = string
   description = "Terrafrom State Key"
}

variable appResourceGroupName {
  type = string
   description = "The name of the resource group that the solution will be contained within."
}

variable baseResourceName {
  type = string
   description = "Enter a unique base name (lower case letter with no space) which is use to generate the domain name."
}

variable botClientId {
  type = string
  description = "The application (client) ID of the bot Azure AD app for MS Teams. The client ID is derived from creating a new communicator app registration."
}

variable azureKeyVaultResourceGroupName {
   type = string      
   description = "Resource group of Azure keyvault"
}

variable azureKeyVaultName {
  type = string
  description =  "Enter Azure vault name"
}

variable azureKeyVaultSecretName {
  type = string
  description =  "Enter Azure vault secret name"
}

variable teamLink {
  type = string
  description =  "Enter Azure vault secret name"
}