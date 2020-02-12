# Steps

* Initialise the remote state
    ```
    pushd remote-state
    terraform init
    terraform apply
    popd
    ```

* Copy the output vars into a file called ./deploy/backend.tfvars
* Build the func
    ```
        pushd deploy 
        ./publish.sh
        terraform init --backend-config=backend.tfvars
        terraform apply
        popd
    ```


## Create ServicePrincipal (for use with remote state)

https://www.terraform.io/docs/providers/azuread/guides/service_principal_client_secret.html

* Show Subscriptions
    `az account list`
* Create a ServicePrincipal
    `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>`
* i.e.
    `az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/810000dd-0000-4ba7-0000-105ee42e0663"`

 ```
{
  "appId": "607c0000-0000-0000-0000-6a100000dddd",
  "displayName": "azure-cli-2020-02-12-12-31-22",
  "name": "http://azure-cli-2020-02-12-12-31-22",
  "password": "45260000-0000-0000-0000-f61700001111",
  "tenant": "fb730000-0000-0000-0000-674200007777"
}
```

These values map to the Terraform variables like so:

* appId is the client_id defined above.
* password is the client_secret defined above.
* tenant is the tenant_id defined above.

## Login As ServicePrincipal
* Az Login
    `az login --service-principal -u CLIENT_ID -p CLIENT_SECRET --tenant TENANT_ID`
* i.e.
    `az login --service-principal -u "<CLIENT_ID>" -p "<CLIENT_SECRET>" --tenant "<TENANT_ID>"`