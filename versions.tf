terraform {
  required_version = ">= 1.2.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 3.14.0"
    }
  }
}
