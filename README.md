# okta-to-aws-saml-terraform
Terraform to automate the setup "connect okta to a single AWS instance" steps described here Https://saml-doc.okta.com/SAML_Docs/How-to-Configure-SAML-2.0-for-Amazon-Web-Service.html

## Prerequisites 
- Terraform `0.12.*`

## Setup
1. Clone this repository

2. SAML.xml

Okta generates an XML file custom to your Okta account. . You will have to supply this file in the project root with the file name `SAML.xml`
To do this:
- First add the ` Add Amazon Web Services` application from you okta admin console console `https://<MY-TEAM-NAME>-admin.okta.com/admin/app/amazon_aws/instance/_new_/`
- On the second page select `SAML 2.0`
- Below the yellow box with the `view setup instructions` button right-click  `Identity Provider metadata` and save the file to this project root with the name `SAML.xml`

3. This project namespaces its resources. Part of its naming convention is to use workspace names
- Run `terraform workspace new production`
- This will create names such as `auth-production-okta-saml`
- if this step is skipped names will look like `auth-default-okta-saml`

3. Run `terraform init` and then `terraform apply`

4. Once terraform finishes it will output the needed values to plug into the okta setup i.e
```HCL2
access-key = *****************
iam-role-name = **************
identity-provider-arn = arn:aws:iam::************:saml-provider/auth-production-okta-saml
secret-key = ****************************************
```
