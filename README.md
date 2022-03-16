# Cloudflare Zone Terraform Module

[![](https://img.shields.io/badge/dynamic/json?color=5c4ee5&label=registry%20version&query=%24.version&url=https%3A%2F%2Fregistry.terraform.io%2Fv1%2Fmodules%2Falex-feel%2Fzone%2Fcloudflare&logo=terraform)](https://registry.terraform.io/modules/alex-feel/zone/cloudflare/latest)
[![](https://img.shields.io/badge/dynamic/json?color=5c4ee5&label=registry%20downloads&query=%24.downloads&url=https%3A%2F%2Fregistry.terraform.io%2Fv1%2Fmodules%2Falex-feel%2Fzone%2Fcloudflare&logo=terraform)](https://registry.terraform.io/modules/alex-feel/zone/cloudflare/latest)
[![](https://img.shields.io/badge/license-GPLv3-c00404.svg)](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/LICENSE)

Terraform module that creates zone resources on Cloudflare.

These types of resources are supported:

* [Cloudflare Zone](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone)
* [Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override)
* [Cloudflare Zone DNSSEC](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec)
* [Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record)

## Usage

You can find examples of using the module [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples).

Also, you can find detailed usage information in [USAGE.md](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md).

## Notes

[Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override):

* If you try to use a zone setting that is available in a higher plan than your current one, the setting will be ignored. Keep in mind that as a result, your configuration may contain zone settings that are not actually applied to the zone, but this keeps you from getting errors when you mistakenly try to change a setting that is not available on your current plan.
* If the value of the `webp` argument is `on` and the value of the `polish` argument is not set or is set to `off`, then the value of the `polish` argument is forced to `lossless`. This allows the `webp` setting to be unambiguously applied bearing in mind that [it is ignored by default](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md#input_webp) unless the `polish` setting is turned on. An explicit value of the `polish` argument other than `null` and `off` will be respected by the module.

[Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record):

* The `name` argument value defaults to `@` (root).
* The `data` argument is not yet supported.
* The `ttl` argument value defaults to `1` (automatic). The value is forced to `1` (automatic), regardless of explicitly set value, if you set the `proxied` argument to `true`.
* The `proxied` argument value defaults to `false` (for records that support it). You must explicitly set this argument value to `true` for the records that you want to proxy through Cloudflare.
* For each record, you need to come up with any valid name and specify it in the `record_name` argument value (see example above). However, if you create records without using this module, you will also need to come up with a name for each `cloudflare_record` resource. I could generate a name based on some raw data, but either I won't be able to generate a sufficiently unique name, or the name will change every time, forcing Terraform to recreate records over and over again.

## License

GNU General Public License v3.0. See LICENSE for full details.
