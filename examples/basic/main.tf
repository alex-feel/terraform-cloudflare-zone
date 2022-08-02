terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

module "acme_com" {
  source = "registry.terraform.io/alex-feel/zone/cloudflare"
  # It is recommended to pin a module to a specific version, available versions can be found at https://github.com/alex-feel/terraform-cloudflare-zone/tags
  version = "x.x.x"

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
      ttl         = 86400
    }
  ]

  page_rules = [
    {
      page_rule_name = "forward_naked_domain_to_www"
      target         = "acme.com/*"
      actions = {
        forwarding_url = {
          status_code = 301
          url         = "https://www.acme.com/$1"
        }
      }
    },
    {
      page_rule_name = "change_login_page_settings"
      target         = "acme.com/login"
      actions = {
        browser_check  = "on"
        security_level = "high"
      }
    }
  ]
}
