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
  # Optional
  records = [
    {
      record_name = "a_main"
      type        = "A"
      value       = "157.131.111.93"
      proxied     = true
    }
  ]
}

# This rule will get priority = 2 because it depends on the rule cloudflare_page_rule.change_login_page_settings
resource "cloudflare_page_rule" "forward_page_to_example_com_page" {
  zone_id = module.acme_com.zone_id
  target  = "acme.com/page"

  actions {
    forwarding_url {
      status_code = 301
      url         = "https://www.example.com/page"
    }
  }

  depends_on = [cloudflare_page_rule.change_login_page_settings]
}

resource "cloudflare_page_rule" "change_login_page_settings" {
  zone_id = module.acme_com.zone_id
  target  = "acme.com/login"

  actions {
    always_online  = "off"
    browser_check  = "on"
    security_level = "high"
  }
}
