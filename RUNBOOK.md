# My Runbook/Cheatsheet

## Common commands
1. https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
1. terraform init
1. terraform plan
1. terraform apply
1. terraform destroy

## Setting up aws vault (aws-vault)
https://github.com/99designs/aws-vault\
1. `brew install --cask aws-vault`
1. `aws-vault add <aws_username>`
1. go into aws console profile to extract your `ACCESS_KEY_ID` and `SECRET_ACCESS_KEY`
1. if have MFA enabled, go to `~/.aws/config` and edit the following
    ```
    [profile <profile_name>]
    region=us-east-1
    mfa_serial=arn:aws:iam::<aws_account_id>:mfa/<aws_username>
    ```
1. `aws-vault exec <profile_name>`
1. run any `aws <resource> ls` to verify
1. to cross assume role, repeat step 2 (add a new profile), provide the same set of credentials, wait for new profile block  to generate, add `include_profile` and `role_arn` into the new profile block
    ```
    [profile <target_profile>]
    include_profile=<main_profile>
    role_arn=arn:aws:iam::<target_aws_account_id>:role/<target_role>
    ```

## Resource creation order
1. 

## Resource deletion order
1. 
