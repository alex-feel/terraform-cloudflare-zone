# Cloudflare Zone Terraform Module

[![](https://img.shields.io/badge/terraform%20registry-published-%235c4ee5?style=flat&logo=terraform)](https://registry.terraform.io/modules/alex-feel/zone/cloudflare/latest)

Terraform module that creates zone resources on Cloudflare.

These types of resources are supported:

* [Cloudflare Zone](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone)
* [Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override)
* [Cloudflare Zone DNSSEC](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec)
* [Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record)

## Usage

Example of using the module:

`main.tf`:

```hcl
terraform {
  required_version = ">=0.15.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.5.0"
    }
  }

  backend "remote" {
    organization = "acme"

    workspaces {
      name = "infrastructure-prod-worldwide"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "acme_com" {
  source  = "alex-feel/zone/cloudflare"
  version = "1.3.0"
  # Required
  zone = "acme.com"
  # Optional
  always_online = "off"
  minify = {
    html = "on"
  }
  enable_dnssec = true
  records = [
    {
      record_name = "a_main"
      type        = "A"
      value       = "157.131.111.93"
      proxied     = true
    },
    {
      record_name = "a_www"
      type        = "A"
      name        = "www"
      value       = "157.131.111.93"
      proxied     = true
    },
    {
      record_name = "mx_1"
      type        = "MX"
      value       = "mx.acme.com"
      priority    = 1
    },
    {
      record_name = "spf_main"
      type        = "TXT"
      value       = "v=spf1 a mx ip4:192.100.66.0/24 a:mail.sonic.net ip4:64.142.0.0/17 ~all"
    }
  ]
}
```

`variables.tf`:

```hcl
variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
  description = "The Cloudflare API token."
}
```

You can find detailed usage information in [USAGE.md](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md).

## Notes

[Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override):

* If you try to use a zone setting that is available in a higher plan than your current one, the setting will be ignored. Keep in mind that as a result, your configuration may contain zone settings that are not actually applied to the zone, but this keeps you from getting errors when you mistakenly try to change a setting that is not available on your current plan.

[Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record):

* The `name` argument value defaults to `@` (root).
* The `data` argument is not yet supported.
* The `ttl` argument value defaults to `1` (automatic). The value is forced to `1` (automatic), regardless of explicitly set value, if you set the `proxied` argument to `true`.
* The `proxied` argument value defaults to `false` (for records that support it). You must explicitly set this argument value to `true` for the records that you want to proxy through Cloudflare.
* For each record, you need to come up with any valid name and specify it in the `record_name` argument value (see example above). However, if you create records without using this module, you will also need to come up with a name for each `cloudflare_record` resource. I could generate a name based on some raw data, but either I won't be able to generate a sufficiently unique name, or the name will change every time, forcing Terraform to recreate records over and over again.

## License

GNU General Public License v3.0. See LICENSE for full details.