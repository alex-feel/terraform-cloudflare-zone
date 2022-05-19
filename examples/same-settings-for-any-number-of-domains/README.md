# How to set the same settings for any number of domains

The configuration in this directory demonstrates how to set the same settings for any number of domains using the module and its features. For example, you can create the same A-record for all domains in the list, or set the same settings for them.

## Usage

To use this example, you need to:

- Have [created](https://support.cloudflare.com/hc/en-us/articles/201720164-Creating-a-Cloudflare-account-and-adding-a-website#6NswogCXqM6TSaxqEf5Bz4) Cloudflare account.
- Have [created](https://developers.cloudflare.com/api/tokens/create/) Cloudflare API token.
- Specify the version constraint for the `cloudflare` provider, using one of the values at [tags](https://github.com/cloudflare/terraform-provider-cloudflare/tags) (preferably the latest), taking into account the minimum requirements at [versions.tf](https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/versions.tf).
- Specify the version constraint for the module, using one of the values at [tags](https://github.com/alex-feel/terraform-cloudflare-zone/tags) (preferably the latest).
- Run the following commands:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```