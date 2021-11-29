# Cloudflare Zone Terraform Module

Terraform module that creates zone resources on Cloudflare.

These types of resources are supported:

* [Cloudflare Zone](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone)
* [Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override)
* [Cloudflare Zone DNSSEC](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec)
* [Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record)

## Usage

Example of using the module:

```hcl
module "acme_com" {
  source        = "alex-feel/zone/cloudflare"
  version       = "1.0.0"
  # Required
  zone          = "acme.com"
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
      value       = "135.180.1.14"
      proxied     = true
    },
    {
      record_name = "a_www"
      type        = "A"
      name        = "www"
      value       = "135.180.1.14"
      proxied     = true
    },
    {
      record_name = "mx_google_1"
      type        = "MX"
      value       = "aspmx.l.google.com"
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

You can find detailed usage information in [USAGE.md](./USAGE.md).

## Notes

[Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override):

* If you try to use a zone setting that is available in a higher plan than your current one, the setting will be ignored. Keep in mind that as a result, your configuration may contain zone settings that are not actually applied to the zone, but this keeps you from getting errors when you mistakenly try to change a setting that is not available on your current plan.

[Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record):

* The `name` argument defaults to `@` (root).
* The `data` argument is not yet supported.
* The `ttl` argument defaults to `1` (automatic). Must be the default when using the `proxied` argument with `true` value.
* The `proxied` argument defaults to `false` (for records that support it). You must explicitly set this argument to `true` for the records that you want to proxy through Cloudflare.
* For each record, you need to come up with any valid name and specify it in the `record_name` argument (see example above), however, if you create records without using this module, you will also need to come up with a name for each `cloudflare_record` resource. I could generate a name based on some raw data, but either I won't be able to generate a sufficiently unique name, or the name will change every time, forcing Terraform to recreate records over and over again.

## License

GNU General Public License v3.0. See LICENSE for full details.