# Cloudflare Zone Terraform Module

[![](https://img.shields.io/badge/dynamic/json?color=5c4ee5&label=registry%20version&query=%24.version&url=https%3A%2F%2Fregistry.terraform.io%2Fv1%2Fmodules%2Falex-feel%2Fzone%2Fcloudflare&logo=terraform)](https://registry.terraform.io/modules/alex-feel/zone/cloudflare/latest)
[![](https://img.shields.io/badge/dynamic/json?color=5c4ee5&label=registry%20downloads&query=%24.downloads&url=https%3A%2F%2Fregistry.terraform.io%2Fv1%2Fmodules%2Falex-feel%2Fzone%2Fcloudflare&logo=terraform)](https://registry.terraform.io/modules/alex-feel/zone/cloudflare/latest)
[![](https://img.shields.io/badge/license-GPLv3-c00404.svg)](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/LICENSE)

Terraform module that creates zone resources on Cloudflare.

The main goals of this module are to simplify the creation of resources in Cloudflare, while reducing the number of possible user mistakes at the earliest possible stage. See notes below for more information.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | >= 3.18.0 |

## Supported Resources

These types of resources are supported:

* [Cloudflare page rule](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule)
* [Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record)
* [Cloudflare Zone](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone)
* [Cloudflare Zone DNSSEC](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec)
* [Cloudflare Zone settings](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override)

<!-- END_TF_DOCS -->

## Usage

It's as simple as:

```hcl
module "acme_com" {
  source = "registry.terraform.io/alex-feel/zone/cloudflare"
  # It is recommended to pin a module to a specific version
  version = "x.x.x"
  zone    = "acme.com"
  # There may be many other arguments here
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

* If you try to use an argument that is available in a higher plan than your current one, the argument will be ignored without errors.
* If you try to set a value for the `security_level` or the `max_upload` argument that is not available on your current plan, the argument value will be set to the closest value available on your current plan.
* If the value of the `webp` argument is `on` and the value of the `polish` argument is not set or is set to `off`, then the value of the `polish` argument is forced to `lossless`. This allows the `webp` argument value to be unambiguously applied bearing in mind that [it is ignored by default](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/USAGE.md#input_webp) unless the `polish` argument value is set to `on`. An explicit value of the `polish` argument other than `null` and `off` will be respected by the module.
* It is not necessary to specify all fields, such as `html`, `css`, and `js` in the `minify` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override#minify) (block in the original resource), despite the fact that according to the documentation all fields are required. You can only specify the fields you need, the rest of the fields will take on the default values.
* It is not necessary to specify `status` and `strip_uri` fields in the `mobile_redirect` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override#mobile_redirect) (block in the original resource), despite the fact that according to the documentation these fields are required. You can only specify the fields you need, the rest of the fields will take on the default values.

[Cloudflare record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record):

* The `name` and the `data["name"]` argument values default to `@` (root). This is actually the default behavior, but only for the value of the `data["name"]` argument when you are not using the module.
* The `data` argument **is supported**. The `value` argument takes precedence over the `data` argument to avoid errors if two arguments are accidentally given at the same time, since only one of them can be given at the same time.
* The `ttl` argument value defaults to `1` (automatic).
* The `ttl` argument value is forced to `1` (automatic), regardless of explicitly set value, if you set the `proxied` argument value to `true`.
* The `proxied` argument value defaults to `false` (for records that support it). You must explicitly set this argument value to `true` for the records that you want to proxy through Cloudflare.
* The `proxied` argument value is forced to `false` for unsupported record types, regardless of explicitly set value.
* The `proxied` argument value is forced to `false` for wildcard records for non-enterprise plans, regardless of explicitly set value, because non-enterprise customers can create but not proxy wildcard records.
* For each record, you need to come up with any valid name and specify it as the `record_name` argument value (see examples [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples)).

[Cloudflare page rule](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule):

* It is not necessary to specify empty `cookie`, `header`, `host`, `query_string`, or `user` objects (blocks in the original resource) in the `cache_key_fields` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#cache-key-fields) (block in the original resource) if you don't need them, despite the fact that, according to the documentation, all blocks are required, but allowed to be empty. You can only specify the objects you need.
* It is not necessary to specify all fields, such as `html`, `css`, and `js` in the `minify` [object](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#minify) (block in the original resource), despite the fact that according to the documentation all fields are required. You can only specify the fields you need, the rest of the fields will take on the default values.
* If you try to use an [action](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#actions) that is available in a higher plan than your current one, the action will be ignored without errors.
* If you try to set a value for the `browser_cache_ttl`, `edge_cache_ttl`, or `security_level` [action](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/page_rule#actions) that is not available on your current plan, the action value will be set to the closest value available on your current plan.
* For each page rule, you need to come up with any valid name and specify it as the `page_rule_name` argument value (see an example [here](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/basic)).
* Due to the specific implementation of the Cloudflare API, in fact, you cannot use the `priority` argument to set the priority of a particular page rule. You can find details in this [issue](https://github.com/cloudflare/terraform-provider-cloudflare/issues/187). If you need to prioritize page rules, in which case you can only partially use the module, creating page rules requires using the regular `cloudflare_page_rule` resources, as well as the `depends_on` meta argument, as described [here](https://github.com/cloudflare/terraform-provider-cloudflare/issues/187#issuecomment-450987683). See an [example](https://github.com/alex-feel/terraform-cloudflare-zone/tree/main/examples/page-rules-with-priorities) of using the module in such a case.

## Get the Latest Changes

If you want to use a module with the latest changes that are not yet available in the Terraform Registry, you need to:

* Change the module `source` argument value from `registry.terraform.io/alex-feel/zone/cloudflare` to `github.com/alex-feel/terraform-cloudflare-zone` and remove the module `version` argument (version constraint), so you have the following:

```hcl
module "acme_com" {
  source = "github.com/alex-feel/terraform-cloudflare-zone"
  zone   = "acme.com"
  # There may be many other arguments here
}
```

* Run the following command (make sure you run this command every time to get new changes):

```bash
$ terraform init -upgrade
```

Note. Be aware of changes in your infrastructure when using the module with the latest changes, carefully examine the output of the `terraform plan` command before applying the changes.

## Share Your Support

Like the project? Please give it a star! You can find more about starring [here](https://docs.github.com/en/get-started/exploring-projects-on-github/saving-repositories-with-stars).

## Contributors

<a href="https://github.com/alex-feel/terraform-cloudflare-zone/graphs/contributors"><img src="https://contrib.rocks/image?repo=alex-feel/terraform-cloudflare-zone" /></a>

<sup>Made with [contrib.rocks](https://contrib.rocks).</sup>

## License

GNU General Public License v3.0. See [LICENSE](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/LICENSE) for full details.
