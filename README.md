# netzon-ks-k3s
Netzon Knowledge Sharing: Kubernetes (K8s) and K3s

## Terraform
### :warning: Important Notes
1. The created resources may incur charges, check and adjust them accordingly
2. Don't forget to destroy all resources including the S3 bucket that holds Terraform state

### Requirements
1. Properly installed Terraform CLI *([installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli))*
1. IAM User with `AdministratorAccess` permission *(given permission is for demo purposes only, adjust accordingly)*
1. AWS CLI Access Keys
    ```shell
    $ export AWS_ACCESS_KEY_ID=**************
    $ export AWS_SECRET_ACCESS_KEY=**************
    $ export AWS_DEFAULT_REGION=us-east-1
    ```
    or run
    ```shell
    $ aws configure
    ```
1. AWS S3 bucket where Terraform state will be saved. To create, run
    ```shell
    $ aws s3api create-bucket --bucket netzon-ks-k3s
    ```
    **Note:** You may need to use other s3 bucket name other than `netzon-ks-k3s`
1. [Optional] Set Terraform variable to environment
    ```shell
    $ export TF_VAR_ssh_public_key_base64=**************
    ```

### Terraform

#### Initialize
```shell
$ terraform init
```

#### Plan
```shell
$ terraform plan
```

#### Create Resources
```shell
$ terraform apply --auto-approve
```

#### Update/Fix config drifts
```shell
$ terraform apply --auto-approve
```

#### Destroy Resources
```shell
$ terraform destroy --auto-approve
```

## K3s
Official website: [https://k3s.io/](https://k3s.io/)

### Installation
[https://docs.k3s.io/installation](https://docs.k3s.io/installation)

```shell
$ sudo curl -sfL https://get.k3s.io | sh -
```

### Verify installation
```shell
$ sudo systemctl status k3s
```
