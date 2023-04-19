# azure-containerapp-private

```
$resourceGroup  = "<rg>"
$location = "westeurope"

az group create --name $resourceGroup --location $location

```

# Set GitHub secrets
Standing on the git directory

```
$subscriptionId = "<suscription>"
$resourceGroup  = "<rg>"
$githubRepo     = "crgarcia12/azure-containerapp-private"

# Create a Service Principal. The result is an array, concatenate it and convert to json
$servicePrincipalJson = az ad sp create-for-rbac --name "crgar-glb-githubaction" --role owner --scopes /subscriptions/$subscriptionId --sdk-auth
$servicePrincipalJson = [string]::Concat($servicePrincipalJson)
$servicePrincipal = $servicePrincipalJson  | Convertfrom-json

gh secret set AZURE_CLIENT_ID     --repos $githubRepo --body $servicePrincipal.clientId
gh secret set AZURE_CLIENT_SECRET --repos $githubRepo --body $servicePrincipal.clientSecret
gh secret set AZURE_TENANT_ID     --repos $githubRepo --body $servicePrincipal.tenantId
gh secret set AZURE_SUBSCRIPTION  --repos $githubRepo --body $servicePrincipal.subscriptionId
gh secret set AZURE_CREDENTIALS   --repos $githubRepo --body $servicePrincipalJson
gh secret set AZURE_RG            --repos $githubRepo --body $resourceGroup
```