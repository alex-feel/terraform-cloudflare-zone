# Cloudflare Zone Terraform Module

[![](https://img.shields.io/badge/dynamic/json?color=5c4ee5&label=registry%20version&query=%24.version&url=https%3A%2F%2Fregistry.terraform.io%2Fv1%2Fmodules%2Falex-feel%2Fzone%2Fcloudflare&logo=terraform)](https://registry.terraform.io/modules/alex-feel/zone/cloudflare/latest)
[![](https://img.shields.io/badge/dynamic/json?color=5c4ee5&label=registry%20downloads&query=%24.downloads&url=https%3A%2F%2Fregistry.terraform.io%2Fv1%2Fmodules%2Falex-feel%2Fzone%2Fcloudflare&logo=terraform)](https://registry.terraform.io/modules/alex-feel/zone/cloudflare/latest)
[![](https://img.shields.io/badge/license-GPLv3-c00404.svg)](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/LICENSE)

Terraform module that creates zone resources on Cloudflare.

The main goals of this module are to simplify the creation of resources in Cloudflare, while reducing the number of possible user mistakes. See notes below for more information.

## Supported Resources

These types of resources are supported:

* [Cloudflare Zone](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone)
* [Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override)
* [Cloudflare Zone DNSSEC](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec)
* [Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record)

## Usage

You can find examples of using the module [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples), including:

* A basic [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/basic).
* An [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/creating-record-using-data-argument) of how to create a record using the `data` argument.
* An [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/stop-email-spoofing-of-parked-domains) of how to stop email spoofing of parked domains.

Also, you can find detailed usage information in [USAGE.md](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md).

## Notes

[Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override):

* If you try to use a zone setting that is available in a higher plan than your current one, the setting will be ignored without errors.
* If the value of the `webp` argument is `on` and the value of the `polish` argument is not set or is set to `off`, then the value of the `polish` argument is forced to `lossless`. This allows the `webp` setting to be unambiguously applied bearing in mind that [it is ignored by default](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md#input_webp) unless the `polish` setting is turned on. An explicit value of the `polish` argument other than `null` and `off` will be respected by the module.

[Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record):

* The `name` argument value defaults to `@` (root).
* The `data` argument **is supported**. The `value` argument takes precedence over the `data` argument to avoid errors if two arguments are accidentally given at the same time, since only one of them can be given at the same time.
* The `ttl` argument value defaults to `1` (automatic).
* The `ttl` argument value is forced to `1` (automatic), regardless of explicitly set value, if you set the `proxied` argument to `true`.
* The `proxied` argument value defaults to `false` (for records that support it). You must explicitly set this argument value to `true` for the records that you want to proxy through Cloudflare.
* The `proxied` argument value is forced to `false` for unsupported record types, regardless of explicitly set value.
* The `proxied` argument value is forced to `false` for wildcard records for non-enterprise plans, regardless of explicitly set value, because non-enterprise customers can create but not proxy wildcard records.
* For each record, you need to come up with any valid name and specify it in the `record_name` argument value (see examples [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples)).

## License

GNU General Public License v3.0. See [LICENSE](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/LICENSE) for full details.
