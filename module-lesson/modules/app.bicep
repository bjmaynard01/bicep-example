@description('The azure region into which the resources should be deployed.')
param location string

@description('The name of the app service app.')
param appServiceAppName string

@description('The name of the app service plan.')
param appServicePlanName string

@description('The name of the app service plan sku')
param appServicePlanSkuName string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

@description('The default host name of the app service app')
output appServiceAppHostName string = appServiceApp.properties.defaultHostName
