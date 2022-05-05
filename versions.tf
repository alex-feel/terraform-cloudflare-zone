terraform {
  required_version = ">= 0.15.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.11.0"
    }
  }
}
