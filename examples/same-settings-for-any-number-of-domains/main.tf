terraform {
  required_version = ">=0.15.0"

  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      # Specify the correct version, taking into account the minimum requirements at https://github.com/alex-feel/terraform-cloudflare-zone/blob/main/providers.tf
      # You can usually use the latest version available at https://github.com/cloudflare/terraform-provider-cloudflare/tags
      version = "x.x.x"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  domains = [
    "acme.com",
    "example.com",
    "example.net",
    "example.org",
    "example.edu"
  ]
  ipv4 = "157.131.111.93"
}

module "domains" {
  source = "registry.terraform.io/alex-feel/zone/cloudflare"
  # It is recommended to pin a module to a specific version, available versions can be found at https://github.com/alex-feel/terraform-cloudflare-zone/tags
  version = "x.x.x"

  for_each = toset(local.domains)

  # Required
  zone = each.value

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
      value       = local.ipv4
      proxied     = true
    },
    {
      record_name = "a_www"
      type        = "A"
      name        = "www"
      value       = local.ipv4
      proxied     = true
    }
  ]

  page_rules = [
    {
      page_rule_name = "forward_naked_domain_to_www"
      target         = "${each.value}/*"
      actions = {
        forwarding_url = {
          status_code = 301
          url         = "https://www.${each.value}/$1"
        }
      }
    }
  ]
}