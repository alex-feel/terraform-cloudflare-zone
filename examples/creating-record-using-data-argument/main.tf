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

module "acme_com" {
  source = "registry.terraform.io/alex-feel/zone/cloudflare"
  # It is recommended to pin a module to a specific version, available versions can be found at https://github.com/alex-feel/terraform-cloudflare-zone/tags
  version = "x.x.x"

  # Required
  zone = "acme.com"

  records = [
    {
      record_name = "a_sip"
      type        = "A"
      name        = "sip"
      value       = "157.131.111.9"
    },
    {
      record_name = "srv_sip_tls"
      name        = "_sip._tls"
      type        = "SRV"
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
