export RESOURCE_GROUP_NAME="rg-module-test-01"
export REGION="westeurope"
export VM_NAME="aivm01"
export USERNAME="azureadmin"
export VM_SIZE="Standard_D2s_v5"

# rg
az group create --name $RESOURCE_GROUP_NAME --location $REGION

# virtual network
az network vnet create --resource-group $RESOURCE_GROUP_NAME --name "$VM_NAME-vnet" --address-prefix "192.168.0.0/16" \
    --location $REGION \
    --subnet-name "GL-subnet" --subnet-prefix "192.168.1.0/24"

# Public IP
az network public-ip create --resource-group $RESOURCE_GROUP_NAME  --name "$VM_NAME-pip"

# network security group
az network nsg create --resource-group $RESOURCE_GROUP_NAME  --name "$VM_NAME-nsg"

# Nic
az network nic create \
  --resource-group $RESOURCE_GROUP_NAME \
  --name "$VM_NAME-nic" \
  --vnet-name "$VM_NAME-vnet" \
  --subnet "GL-subnet" \
  --network-security-group "$VM_NAME-nsg" \
  --public-ip-address "$VM_NAME-pip"

# vm
az vm create \
  --resource-group $RESOURCE_GROUP_NAME \
  --name $VM_NAME \
  --nics "$VM_NAME-nic" \
  --image Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest \
  --generate-ssh-keys \
  --size $VM_SIZE \
  --admin-username $USERNAME \


# Allow SSH (22)
az network nsg rule create \
  --resource-group $RESOURCE_GROUP_NAME \
  --nsg-name "$VM_NAME-nsg" \
  --name "Allow-SSH" \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 22

# Allow HTTP (80)
az network nsg rule create \
  --resource-group $RESOURCE_GROUP_NAME \
  --nsg-name "$VM_NAME-nsg" \
  --name "Allow-HTTP" \
  --priority 110 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 80

# Allow HTTPS (443)
az network nsg rule create \
  --resource-group $RESOURCE_GROUP_NAME \
  --nsg-name "$VM_NAME-nsg" \
  --name "Allow-HTTPS" \
  --priority 120 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 443 3000 11434