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
    google = google.<PROVIDER ALIAS>
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