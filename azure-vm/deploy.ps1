# PowerShell script to deploy the Azure VM. Uses Azure CLI.
#

# Variables
$RESOURCE_GROUP = "NextCloud-rg"
$LOCATION = "uksouth"
$VM_NAME = "NextCloud-VM"
$VM_SIZE = "Standard_B2s"
$IMAGE = "Ubuntu2404"

$ADMIN_USER = "azureuser"
$CloudInitFile = "cloud-init.yml"
$RequiredPorts = "80,443"


# Create resource group
Write-Output "Creating resource group $RESOURCE_GROUP in $LOCATION"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create VM
Write-Output "Creating VM $VM_NAME in $RESOURCE_GROUP"
az vm create `
    --resource-group $RESOURCE_GROUP `
    --name $VM_NAME `
    --image $IMAGE `
    --size $VM_SIZE `
    --admin-username $ADMIN_USER `
    --generate-ssh-keys `
    --custom-data $CloudInitFile

# Open ports
Write-Output "Opening ports $RequiredPorts on VM $VM_NAME"
az vm open-port --port $RequiredPorts --resource-group $RESOURCE_GROUP --name $VM_NAME --priority 1001

# Get public IP
$publicIp = az vm show --resource-group $RESOURCE_GROUP --name $VM_NAME --show-details --query publicIps --output tsv

Write-Output "VM is ready. Log in using the following command:"
Write-Output "ssh $ADMIN_USER@$publicIp"

# copy docker-compose and .env files to VM
scp -r docker-compose.yml .env $ADMIN_USER@${publicIp}:/home/$ADMIN_USER

# Clean up
# az group delete --name $RESOURCE_GROUP --yes --no-wait
