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
  account_id = "c2tby9ikk6f0mpa7njg0waa4o2m5jnr3"
  zone       = "acme.com"

  records = [
    {
      record_name = "a_sip"
      type        = "A"
      name        = "sip"
      value       = "157.131.111.9"
    },
    {
      record_name = "srv_sip_tls"
      type        = "SRV"
      name        = "_sip._tls"
      data = {
        service  = "_sip"
        proto    = "_tls"
        priority = 0
        weight   = 0
        port     = 5061
        target   = "sip.acme.com"
      }
    }
  ]
}
