# Terraform for Pre Initialisation of Cluster.

## Description
This section deals with the pre initialisation of the cluster. That is, For a proper RBAC enabled Kubernetes cluster  with Terraform, it needs, an `Azure service principal` with the role contributor, an storage to store the state of the terraform (Azure storage account). I have used an approach to create a common azure key vault for this process. The module `secret` creates a scaffolding of the secrets  needed for running the `post-init` phase of the cluster. You can copy terraform service principal, azure AD configurations for RBAC and ARM_ACCESS_KEY for accessing the storage account for terraform state. I have created modules accordingly which will do this! Modules section has more details.

## Prerequisites
1. Azure Service Principal for terraform (terraform-k8s). #TODO I shall update the script soon.
2. Storage account to store the terraform state for `pre-init` configurations.
3. Azure Active Directory Credentials for maintaing RBAC for K8s Cluster on Azure (AKSAADClient and AKSAADServer)
4. Azure Active Directory Group for enabling RBAC.

**Note:** Note that the azure backend ACCESS_KEY for terraform should be provided by env variables since it cannot be interpolated via vault.


## Terraform Modules
1. `aks-storage` for setting up azure k8s storage account for `post-init`.
2. `resource-group` for setting up a resource group for common infrastructure components.
3. `secrets` for setting up a common azure key vault and define placeholder for secret values.
4. `acr` Add azure continer registry. However this is totally a one time activity in the lifecycle of azure development.

## Usage
1. Set the Terraform Backend Azure Storage Account Access Key. \
You can either directly use the ARM access key and paste it or use it from a private existing vault if you have configured one. I would suggest to have the vault pre-configured for this.!
``$ export ARM_ACCESS_KEY=$(az keyvault secret show --name <tf-armAccessKey> --vault-name <pre-init-vault-name> --query value -o tsv)``
2. Initialize terraform \
``$ terraform init -backend-config="env/global/backend.tfvars" -var-file="env/global/common.tfvars"``
3. Terraform list modules \
``$ terraform get``
4. Create a output plan before actually applying the plan. \
``$ terraform plan -var-file="env/global/common.tfvars" -out=output.plan``
5. If the output is successful with the values as desired. Apply the plan. \
``$ terraform apply out.plan``
6. To clean the complete infrastructure. \
``$ terraform destroy -var-file="env/global/common.tfvars"``

## Attention!!
The Repository is for only terraform files and hence **do not** add the state files, plan files and the backup files in the repository.


