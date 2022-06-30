# How to set page rule priorities

The configuration in this directory demonstrates how to set page rule priorities, taking into account the specific implementation of the Cloudflare API. You can find details in this [issue](https://github.com/cloudflare/terraform-provider-cloudflare/issues/187).

## Usage

To use this example, you need to:

- Have [created](https://support.cloudflare.com/hc/en-us/articles/201720164-Creating-a-Cloudflare-account-and-adding-a-website#6NswogCXqM6TSaxqEf5Bz4) Cloudflare account.
- Have [created](https://developers.cloudflare.com/api/tokens/create/) Cloudflare API token.
- Specify the version constraint for the module, using one of the values at [tags](https://github.com/alex-feel/terraform-cloudflare-zone/tags) (preferably the latest).
- Run the following commands:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```
