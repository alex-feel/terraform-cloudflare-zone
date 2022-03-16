terraform {
  required_version = ">=0.15.0"

  cloud {
    organization = "acme"

    workspaces {
      name = "infrastructure-prod-worldwide"
    }
  }

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
      record_name = "txt_spf_wildcard"
      type        = "TXT"
      name        = "*"
      value       = "v=spf1 -all"
    },
    {
      record_name = "txt_spf_main"
      type        = "TXT"
      value       = "v=spf1 -all"
    },
    {
      record_name = "txt_dmarc"
      type        = "TXT"
      name        = "_dmarc"
      value       = "v=DMARC1; p=reject"
    }
  ]
}
