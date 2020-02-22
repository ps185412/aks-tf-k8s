# Terraform for Azure Kubernetes Service with RBAC

## Description
The Functionality is divided into 2 parts.

### Pre-Initialisation of Cluster
This includes basically the things needed before we start creating the cluster.  Configures few components such as ACR(Azure Container Registry), Creating a azure storage account for Terraform state for Post-Initialisation and creates a common azure vault for secret storage. However to execute this you have to first create a service principal for terraform via `az cli` and create a storage account for this part of terraform state. For these 2 things you can have scripts as part of your automation process. It is **strictly recommended** to be run this via admin rights and keep it restricted and confidential.
   After this phase is created you can expect  it creates ACR, storage account for terraform state and azure key vault to store the secrets( Service Principal etc).

### Post-Initialisation of Cluster
Here we can configure the Azure key vault secrets such as service principal and azure AD credentials. This is recommended so no values are stored in `*.tfvars` files. Adding secret to the vault has to be done vi `az cli` scripts though and a one time activity.

More Details can be found on respective terraform component.