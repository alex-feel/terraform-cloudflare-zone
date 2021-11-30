terraform {
  experiments = [module_variable_optional_attrs]
}

locals {
  avail_starting_with_pro        = ["pro", "business", "enterprise"]
  avail_starting_with_business   = ["business", "enterprise"]
  avail_starting_with_enterprise = ["enterprise"]
}

locals {
  http2_avail                       = local.avail_starting_with_pro
  http3_avail                       = local.avail_starting_with_pro
  ipv6_avail                        = local.avail_starting_with_pro
  mirage_avail                      = local.avail_starting_with_pro
  origin_error_page_pass_thru_avail = local.avail_starting_with_enterprise
  prefetch_preload_avail            = local.avail_starting_with_enterprise
  response_buffering_avail          = local.avail_starting_with_enterprise
  sort_query_string_for_cache_avail = local.avail_starting_with_enterprise
  tls_client_auth_avail             = local.avail_starting_with_enterprise
  true_client_ip_header_avail       = local.avail_starting_with_enterprise
  waf_avail                         = local.avail_starting_with_pro
  webp_avail                        = local.avail_starting_with_pro
  zero_rtt_avail                    = local.avail_starting_with_pro
  cname_flattening_avail            = local.avail_starting_with_pro
  h2_prioritization_avail           = local.avail_starting_with_pro
  image_resizing_avail              = local.avail_starting_with_business
  polish_avail                      = local.avail_starting_with_pro
  pseudo_ipv4_avail                 = local.avail_starting_with_pro
}

locals {
  http2                       = contains(local.http2_avail, var.plan) ? var.http2 : null
  http3                       = contains(local.http3_avail, var.plan) ? var.http3 : null
  ipv6                        = contains(local.ipv6_avail, var.plan) ? var.ipv6 : null
  mirage                      = contains(local.mirage_avail, var.plan) ? var.mirage : null
  origin_error_page_pass_thru = contains(local.origin_error_page_pass_thru_avail, var.plan) ? var.origin_error_page_pass_thru : null
  prefetch_preload            = contains(local.prefetch_preload_avail, var.plan) ? var.prefetch_preload : null
  response_buffering          = contains(local.response_buffering_avail, var.plan) ? var.response_buffering : null
  sort_query_string_for_cache = contains(local.sort_query_string_for_cache_avail, var.plan) ? var.sort_query_string_for_cache : null
  tls_client_auth             = contains(local.tls_client_auth_avail, var.plan) ? var.tls_client_auth : null
  true_client_ip_header       = contains(local.true_client_ip_header_avail, var.plan) ? var.true_client_ip_header : null
  waf                         = contains(local.waf_avail, var.plan) ? var.waf : null
  webp                        = contains(local.webp_avail, var.plan) ? var.webp : null
  zero_rtt                    = contains(local.zero_rtt_avail, var.plan) ? var.zero_rtt : null
  cname_flattening            = contains(local.cname_flattening_avail, var.plan) ? var.cname_flattening : null
  h2_prioritization           = contains(local.h2_prioritization_avail, var.plan) ? var.h2_prioritization : null
  image_resizing              = contains(local.image_resizing_avail, var.plan) ? var.image_resizing : null
  polish                      = contains(local.polish_avail, var.plan) ? var.polish : null
  pseudo_ipv4                 = contains(local.pseudo_ipv4_avail, var.plan) ? var.pseudo_ipv4 : null
}

locals {
  minify = defaults(var.minify, {
    css  = "off"
    html = "off"
    js   = "off"
  })

  mobile_redirect = defaults(var.mobile_redirect, {
    status    = "off"
    strip_uri = false
  })

  security_header = defaults(var.security_header, {
    enabled            = true
    preload            = false
    max_age            = 86400
    include_subdomains = true
    nosniff            = true
  })

  records = defaults(var.records, {
    name    = "@"
    ttl     = 1
    proxied = false
  })
}

resource "cloudflare_zone" "this" {
  zone       = var.zone
  paused     = var.paused
  jump_start = var.jump_start
  plan       = var.plan
  type       = var.type
}

resource "cloudflare_zone_settings_override" "this" {
  zone_id = cloudflare_zone.this.id

  settings {
    always_online               = var.always_online
    always_use_https            = var.always_use_https
    automatic_https_rewrites    = var.automatic_https_rewrites
    brotli                      = var.brotli
    browser_check               = var.browser_check
    development_mode            = var.development_mode
    email_obfuscation           = var.email_obfuscation
    hotlink_protection          = var.hotlink_protection
    http2                       = local.http2
    http3                       = local.http3
    ip_geolocation              = var.ip_geolocation
    ipv6                        = local.ipv6
    mirage                      = local.mirage
    opportunistic_encryption    = var.opportunistic_encryption
    opportunistic_onion         = var.opportunistic_onion
    origin_error_page_pass_thru = local.origin_error_page_pass_thru
    prefetch_preload            = local.prefetch_preload
    privacy_pass                = var.privacy_pass
    response_buffering          = local.response_buffering
    rocket_loader               = var.rocket_loader
    server_side_exclude         = var.server_side_exclude
    sort_query_string_for_cache = local.sort_query_string_for_cache
    tls_client_auth             = local.tls_client_auth
    true_client_ip_header       = local.true_client_ip_header
    universal_ssl               = var.universal_ssl
    waf                         = local.waf
    webp                        = local.webp
    websockets                  = var.websockets
    zero_rtt                    = local.zero_rtt
    cache_level                 = var.cache_level
    cname_flattening            = local.cname_flattening
    h2_prioritization           = local.h2_prioritization
    image_resizing              = local.image_resizing
    min_tls_version             = var.min_tls_version
    polish                      = local.polish
    pseudo_ipv4                 = local.pseudo_ipv4
    security_level              = var.security_level
    ssl                         = var.ssl
    tls_1_3                     = var.tls_1_3
    browser_cache_ttl           = var.browser_cache_ttl
    challenge_ttl               = var.challenge_ttl
    max_upload                  = var.max_upload

    minify {
      css  = local.minify.css
      html = local.minify.html
      js   = local.minify.js
    }

    mobile_redirect {
      mobile_subdomain = var.mobile_redirect.mobile_subdomain
      status           = local.mobile_redirect.status
      strip_uri        = local.mobile_redirect.strip_uri
    }

    security_header {
      enabled            = local.security_header.enabled
      preload            = local.security_header.preload
      max_age            = local.security_header.max_age
      include_subdomains = local.security_header.include_subdomains
      nosniff            = local.security_header.nosniff
    }
  }
}

resource "cloudflare_zone_dnssec" "this" {
  count = var.enable_dnssec ? 1 : 0

  zone_id = cloudflare_zone.this.id
}

resource "cloudflare_record" "this" {
  for_each = var.records != null ? { for record in local.records : record.record_name => record } : {}

  zone_id = cloudflare_zone.this.id

  type     = each.value.type
  name     = each.value.name
  value    = each.value.value
  priority = each.value.priority
  ttl      = contains(["a", "aaaa", "cname"], lower(each.value.type)) && each.value.proxied == true ? 1 : each.value.ttl
  proxied  = each.value.proxied
}
