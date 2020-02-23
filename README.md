# Terraform for Azure Kubernetes Service with RBAC

## Description
This is a quick suite of Azure Services needed to start a kubernetes service. Once can achive below azure functionalities after executing the scripts.

1. Create Storage account for Terraform State.
2. Create your own Virtual network.
3. Create Kubernetes Cluster with RBAC and assigned to Azure AD( already existing)
4. Web Application Gateway ( map already existing domain certificates )
5. Log Analytics for Cluster
6. Azure key vault to store secrets( Service principal, Azure AD credentials) and many more.
7. Creating DNS Zone Records for Application Gateway
8. Create storage accounts for Kubernetes Volume for which you can create your own `azurerm_storage_share`
9. You can add more modules to this as per the need

It is taken care in 2 parts

### Initialisation of Cluster
This includes basically the things needed before we start creating the cluster.  Configures few components such as ACR(Azure Container Registry), Creating a azure storage account for Terraform state for Post-Initialisation and creates a common azure vault for secret storage. However to execute this you have to first create a service principal for terraform via `az cli` and create a storage account for this part of terraform state. For these 2 things you can have scripts as part of your automation process. It is **strictly recommended** to be run this via admin rights and keep it restricted and confidential.
   After this phase is created you can expect  it creates ACR, storage account for terraform state and azure key vault to store the secrets( Service Principal etc).

### Post-Initialisation of Cluster
Here we can configure the Azure key vault secrets such as service principal and azure AD credentials. This is recommended so no values are stored in `*.tfvars` files. Adding secret to the vault has to be done vi `az cli` scripts though and a one time activity.

More Details can be found on respective terraform component.