# Google KMS Keyring Terraform Module

Terraform Module for provisioning a GCP KMS Keyring. This module allows you to provision a GCP KMS Keyring and all of its underlying keys by specifiying an authoritative IAM policy for each crypto key resource. 

## Module Usage

```hcl 
module "keyring_example" {
  source  = "./terraform-google-kms-keyring"

  keyring_name     = "exapmle_ring"
  keyring_location = "us-west2"
  keys = [
    {
      key_name        = "test_key",
      purpose         = "ENCRYPT_DECRYPT",
      rotation_period = "2592000s",
      version_template = {
        algorithm        = "RSA_SIGN_PKCS1_3072_SHA256",
        protection_level = "SOFTWARE"
      },
      permissions = [
        {
          members = [
            "serviceAccount:<SERVICE ACCOUNT EMAIL>",
            "user:<USER EMAIL>",
            "group:<GROUP EMAIL>",
            "domain:<DOMAIN>"
          ],
          role    = <ROLE>,
          condition = {
            title       = <TITLE>,
            description = <DESCRIPTION>,
            expression  = <EXPRESSION>
          }
        }
      ]
    }
  ]

  providers = {
    google = google-beta.<PROVIDER ALIAS>
  }
}
```

If desired, `version_template` can be set to `null`.

If you want to create a key with permissions that don't have any conditions, simply pass empty strings to the `condition` variable:

    condition = {
      title       = "",
      description = "",
      expression  = ""
    }

## Google Beta Provider

**YOU MUST USE** the `google-beta` provider with `version = "~> 3.10.0"` with this module. Without this provider, it is impossible to specify conditions with the IAM policies used to govern the keys on the keyring. 

```hcl
provider "google-beta" {
  alias   = <ALIAS>
  project = <PROJECT ID>
  region  = <REGION>
  version = "~> 3.10.0"
}
```