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
* [Cloudflare page rule](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule)

## Usage

It's as simple as:

```hcl
module "acme_com" {
  source = "registry.terraform.io/alex-feel/zone/cloudflare"
  # It is recommended to pin a module to a specific version
  version = "x.x.x"
  zone    = "acme.com"
  # There may be many other settings here
}
```

You can find examples of using the module [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples), including:

* A basic [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/basic).
* An [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/creating-record-using-data-argument) of how to create a record using the `data` argument.
* An [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/same-settings-for-any-number-of-domains) of how to set the same settings for any number of domains.
* An [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/stop-email-spoofing-of-parked-domains) of how to stop email spoofing of parked domains.

Also, you can find detailed usage information in [USAGE.md](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md).

## Notes

[Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override):

* If you try to use a zone setting that is available in a higher plan than your current one, the setting will be ignored without errors.
* If you try to set a value for the `security_level` or the `max_upload` setting that is not available on your current plan, the setting value will be set to the closest value available on your current plan.
* If the value of the `webp` argument is `on` and the value of the `polish` argument is not set or is set to `off`, then the value of the `polish` argument is forced to `lossless`. This allows the `webp` setting to be unambiguously applied bearing in mind that [it is ignored by default](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md#input_webp) unless the `polish` setting is turned on. An explicit value of the `polish` argument other than `null` and `off` will be respected by the module.
* It is not necessary to specify all arguments, such as `html`, `css`, and `js` in the `minify` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override#minify) (block in the original resource), despite the fact that according to the documentation all arguments are required. You can only specify the arguments you need, the rest of the arguments will take on the default values.
* It is not necessary to specify `status` and `strip_uri` arguments in the `mobile_redirect` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override#mobile_redirect) (block in the original resource), despite the fact that according to the documentation these arguments are required. You can only specify the arguments you need, the rest of the arguments will take on the default values.

[Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record):

* The `name` argument value defaults to `@` (root).
* The `data` argument **is supported**. The `value` argument takes precedence over the `data` argument to avoid errors if two arguments are accidentally given at the same time, since only one of them can be given at the same time.
* The `ttl` argument value defaults to `1` (automatic).
* The `ttl` argument value is forced to `1` (automatic), regardless of explicitly set value, if you set the `proxied` argument to `true`.
* The `proxied` argument value defaults to `false` (for records that support it). You must explicitly set this argument value to `true` for the records that you want to proxy through Cloudflare.
* The `proxied` argument value is forced to `false` for unsupported record types, regardless of explicitly set value.
* The `proxied` argument value is forced to `false` for wildcard records for non-enterprise plans, regardless of explicitly set value, because non-enterprise customers can create but not proxy wildcard records.
* For each record, you need to come up with any valid name and specify it in the `record_name` argument value (see examples [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples)).

[Cloudflare page rule](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule):

* It is not necessary to specify empty `cookie`, `header`, `host`, `query_string`, or `user` objects (blocks in the original resource) in the `cache_key_fields` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#cache-key-fields) (block in the original resource) if you don't need them, despite the fact that, according to the documentation, all blocks are required, but allowed to be empty. You can only specify the objects you need.
* It is not necessary to specify all arguments, such as `html`, `css`, and `js` in the `minify` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#minify) (block in the original resource), despite the fact that according to the documentation all arguments are required. You can only specify the arguments you need, the rest of the arguments will take on the default values.
* If you try to use an [action](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#actions) that is available in a higher plan than your current one, the action will be ignored without errors.
* If you try to set a value for the `security_level` [action](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#actions) that is not available on your current plan, the action value will be set to the closest value available on your current plan.
* For each page rule, you need to come up with any valid name and specify it in the `page_rule_name` argument value (see an example [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/basic)).
* Due to the specific implementation of the Cloudflare API, in fact, you cannot use the `priority` argument to set the priority of a particular page rule. You can find details in this [issue](https://github.com/cloudflare/terraform-provider-cloudflare/issues/187). If you need to prioritize page rules, in which case you can only partially use the module, creating page rules requires using the regular `cloudflare_page_rule` resources, as well as the `depends_on` meta argument, as described [here](https://github.com/cloudflare/terraform-provider-cloudflare/issues/187#issuecomment-450987683). See an [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/page-rules-with-priorities) of using the module in such a case.

## License

GNU General Public License v3.0. See [LICENSE](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/LICENSE) for full details.

<sup>Made by Alex Feel and [contributors](https://github.com/alex-feel/terraform-cloudflare-zone/graphs/contributors).</sup>
