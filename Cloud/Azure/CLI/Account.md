
az login 
az login --allow-no-subscriptions


az config <set/unset/get>
az config set core.enable_broker_on_windows=false


az account show 
az account set --subscription "SUBSCRIPTION_NAME_OR_ID"

az account set/unset/get/show/list



## Azure CLI aruguments/options 
-n --name --> name of resource 
-l --location  --> location/region
-g --resource-group --> Resource group 
-o --output  --> output format
--query   --> JMESPath query to filter output(--query "[].name").

az group create -l eastus -n test-group 

az resource list -o table 
az resource list -o table -q "[].{Name:name, Location:location}"
az network vnet list -g group-1 -o table




## To Add Azure CLI extensions 
az extenstions list -o output
az extenstions list-available -o output 

az extension add -n terraform
az extension add -n azure-devops
az extension add -n storage-preview
az extension add --name aks-preview
