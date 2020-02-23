# Terraform For Creating Kubernetes Cluster

## Description
Scripts to bootstrap the Azure environment with K8S setup. We use  Azure blob storage to store the state file. The Azure File Vault Secret is use to store the sensitive information needed for terraform to bootstrap. The Vault is created in `init` terraform scripts of this repository`. 

Few things to be taken care before running the post-init terraform scripts. Since there are few placeholders which needs to be filled. below are details.
1. The secret names needed for tf service principal, azure AD are to be defined in the common-vault created in `init` terraform scripts and hence the names are as per your own wish. Precisely with the `fetch-from-vault.tf` the secret name is not given hence you may get  read prompt from terraform. Please fill these values and also make sure that the values are environment dependent so that if anyone creates a new `env` folder with `cluster.tfvars` old values are not overwritten.

## Pre-requisite
For Terraform to boostrap it need below details.
Note: It is recommended to store below details in the common-vault created during `init` phase
1. Azure Service Principal (Client ID) and Password(Client Secret) 
2. ARM ACCESS KEY to store the terraform state.
3. Azure Active Directory Credentials for maintaing RBAC for K8s Cluster on Azure

**Note:** Note that the azure backend ACCESS_KEY for terraform should be provided by env variables since it cannot be interpolated via vault.

## Terraform Modules
Separate Modules are written for reusability of the Terraform scripts instead of sym-linking and copy and pasting the code multiple times for environments. There are 3 modules currently.
1. `aks` for setting up azure k8s with or without RBAC.
2. `rbac` for setting up rbac roles.
3. `tiller` for setting up tiller ( For Helm 2.0 However it is discouraged to use)
4. `helm` helm client
5. `waf` for setting up Azure WAF.
6. `storage-account` for setting up storage account for various scenarios. This is an optional module.
7. `secrets` for creating cluster specific secrets


## Usage
1. Set the Terraform Backend Azure Storage Account Access Key. \
``export ARM_ACCESS_KEY=$(az keyvault secret show --name <tfArmAccessKey> --vault-name <common-vault-name> --query value -o tsv``
2. Initialize terraform ``$ terraform init  -backend-config="env/premium/backend.tfvars" ``
3. Terraform list modules ``$ terraform get``
4. Create a output plan before actually applying the plan. \
``$ terraform plan -var-file="env/global/global.tfvars" -var-file="env/premium/cluster.tfvars" -out out.plan``
5. If the output is successful with the values as desired. Apply the plan. \
``$ terraform apply out.plan``
6. To clean the complete infrastructure. \
``$ terraform destroy -var-file="env/global/global.tfvars" -var-file="env/premium/cluster.tfvars"``

### Special Usage for WAF. 
The application gateway can be configured with the certificates. I am currently using the pfx file stored in `./init-scripts/files/certs/cert.pfx`and the file is being picked up. However this is not a proper solution and I am waiting for the fix mentioned here. https://github.com/terraform-providers/terraform-provider-azurerm/issues/3935 . Hence meanwhile please provide a proper certificate in this location and store the password in the common vault.



### Kubectl Usage for RBAC and Dashboard accessing.
Kubectl command needs to verify the authenticity of user before any api calls. For the first time or whenever the RBAC cluster is deployed. just `` kubectl get pods -n kube-system``
you will be promoted with ``To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code DHL9FF4ZR to authenticate.`` Do the steps as desired.
Access is granted and the cluster can be accessed.


### Important!!!
With Terraform power, the destroy command has to be carefully used. ``terraform destroy -target azurerm_kubernetes_cluster.k8s`` can be selectively used to delete resources. 
This may be useful when we script the terraform deployment
 
## RBAC supported by Terraform
Since this topic needs some background of how RBAC works in K8s within Azure and Terraform context its worth to read below articles for understanding.
1. https://www.terraform.io/docs/providers/kubernetes/r/cluster_role_binding.html
2. https://docs.microsoft.com/en-us/azure/aks/aad-integration#access-cluster-with-azure-ad
3. https://kubernetes.io/docs/reference/access-authn-authz/rbac/

## Issues!
For any prompt from terraform for input values. Please provide necessary variables.
## Attention!!
The Repository is for only terraform files and hence **do not** add the state files, plan files and the backup files in the repository.


