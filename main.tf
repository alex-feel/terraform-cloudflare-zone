terraform {
  # The module functionality uses the defaults function, more details in https://www.terraform.io/language/functions/defaults
  experiments = [module_variable_optional_attrs]
}

locals {
  avail_starting_with_pro        = ["pro", "partners_pro", "business", "partners_business", "enterprise", "partners_enterprise"]
  avail_starting_with_business   = ["business", "partners_business", "enterprise", "partners_enterprise"]
  avail_starting_with_enterprise = ["enterprise", "partners_enterprise"]
}

locals {
  cname_flattening_avail            = local.avail_starting_with_pro
  h2_prioritization_avail           = local.avail_starting_with_pro
  http2_avail                       = local.avail_starting_with_pro
  http3_avail                       = local.avail_starting_with_pro
  image_resizing_avail              = local.avail_starting_with_business
  ipv6_avail                        = local.avail_starting_with_pro
  mirage_avail                      = local.avail_starting_with_pro
  orange_to_orange_avail            = local.avail_starting_with_enterprise
  origin_error_page_pass_thru_avail = local.avail_starting_with_enterprise
  polish_avail                      = local.avail_starting_with_pro
  prefetch_preload_avail            = local.avail_starting_with_enterprise
  proxy_read_timeout_avail          = local.avail_starting_with_enterprise
  pseudo_ipv4_avail                 = local.avail_starting_with_pro
  response_buffering_avail          = local.avail_starting_with_enterprise
  sort_query_string_for_cache_avail = local.avail_starting_with_enterprise
  tls_client_auth_avail             = local.avail_starting_with_enterprise
  true_client_ip_header_avail       = local.avail_starting_with_enterprise
  waf_avail                         = local.avail_starting_with_pro
  webp_avail                        = local.avail_starting_with_pro
  zero_rtt_avail                    = local.avail_starting_with_pro
}

locals {
  security_level_avail_values = contains(local.avail_starting_with_enterprise, var.plan) ? ["off", "essentially_off", "low", "medium", "high", "under_attack"] : ["essentially_off", "low", "medium", "high", "under_attack"]
}

locals {
  security_level_closest_avail_values = {
    "free"              = "essentially_off"
    "pro"               = "essentially_off"
    "partners_pro"      = "essentially_off"
    "business"          = "essentially_off"
    "partners_business" = "essentially_off"
  }
}

# cloudflare_zone resource

resource "cloudflare_zone" "this" {
  zone       = var.zone
  paused     = var.paused
  jump_start = var.jump_start
  plan       = var.plan
  type       = var.type
}

# cloudflare_zone_settings_override resource

locals {
  cname_flattening            = contains(local.cname_flattening_avail, var.plan) ? var.cname_flattening : null
  h2_prioritization           = contains(local.h2_prioritization_avail, var.plan) ? var.h2_prioritization : null
  http2                       = contains(local.http2_avail, var.plan) ? var.http2 : null
  http3                       = contains(local.http3_avail, var.plan) ? var.http3 : null
  image_resizing              = contains(local.image_resizing_avail, var.plan) ? var.image_resizing : null
  ipv6                        = contains(local.ipv6_avail, var.plan) ? var.ipv6 : null
  mirage                      = contains(local.mirage_avail, var.plan) ? var.mirage : null
  orange_to_orange            = contains(local.orange_to_orange_avail, var.plan) ? var.orange_to_orange : null
  origin_error_page_pass_thru = contains(local.origin_error_page_pass_thru_avail, var.plan) ? var.origin_error_page_pass_thru : null
  polish                      = contains(local.polish_avail, var.plan) ? (var.polish == null || var.polish == "off") && local.webp == "on" ? "lossless" : var.polish : null
  prefetch_preload            = contains(local.prefetch_preload_avail, var.plan) ? var.prefetch_preload : null
  proxy_read_timeout          = contains(local.proxy_read_timeout_avail, var.plan) ? var.proxy_read_timeout : null
  pseudo_ipv4                 = contains(local.pseudo_ipv4_avail, var.plan) ? var.pseudo_ipv4 : null
  response_buffering          = contains(local.response_buffering_avail, var.plan) ? var.response_buffering : null
  sort_query_string_for_cache = contains(local.sort_query_string_for_cache_avail, var.plan) ? var.sort_query_string_for_cache : null
  tls_client_auth             = contains(local.tls_client_auth_avail, var.plan) ? var.tls_client_auth : null
  true_client_ip_header       = contains(local.true_client_ip_header_avail, var.plan) ? var.true_client_ip_header : null
  waf                         = contains(local.waf_avail, var.plan) ? var.waf : null
  webp                        = contains(local.webp_avail, var.plan) ? var.webp : null
  zero_rtt                    = contains(local.zero_rtt_avail, var.plan) ? var.zero_rtt : null
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
}

resource "cloudflare_zone_settings_override" "this" {
  zone_id = cloudflare_zone.this.id

  settings {
    always_online               = var.always_online
    always_use_https            = var.always_use_https
    automatic_https_rewrites    = var.automatic_https_rewrites
    brotli                      = var.brotli
    browser_cache_ttl           = var.browser_cache_ttl
    browser_check               = var.browser_check
    cache_level                 = var.cache_level
    challenge_ttl               = var.challenge_ttl
    cname_flattening            = local.cname_flattening
    development_mode            = var.development_mode
    early_hints                 = var.early_hints
    email_obfuscation           = var.email_obfuscation
    h2_prioritization           = local.h2_prioritization
    hotlink_protection          = var.hotlink_protection
    http2                       = local.http2
    http3                       = local.http3
    image_resizing              = local.image_resizing
    ip_geolocation              = var.ip_geolocation
    ipv6                        = local.ipv6
    max_upload                  = var.max_upload
    min_tls_version             = var.min_tls_version
    mirage                      = local.mirage
    opportunistic_encryption    = var.opportunistic_encryption
    opportunistic_onion         = var.opportunistic_onion
    orange_to_orange            = local.orange_to_orange
    origin_error_page_pass_thru = local.origin_error_page_pass_thru
    polish                      = local.polish
    prefetch_preload            = local.prefetch_preload
    privacy_pass                = var.privacy_pass
    proxy_read_timeout          = local.proxy_read_timeout
    pseudo_ipv4                 = local.pseudo_ipv4
    response_buffering          = local.response_buffering
    rocket_loader               = var.rocket_loader
    security_level              = contains(local.security_level_avail_values, var.security_level) ? var.security_level : local.security_level_closest_avail_values[var.plan]
    server_side_exclude         = var.server_side_exclude
    sort_query_string_for_cache = local.sort_query_string_for_cache
    ssl                         = var.ssl
    tls_1_3                     = var.tls_1_3
    tls_client_auth             = local.tls_client_auth
    true_client_ip_header       = local.true_client_ip_header
    universal_ssl               = var.universal_ssl
    waf                         = local.waf
    webp                        = local.webp
    websockets                  = var.websockets
    zero_rtt                    = local.zero_rtt

    //noinspection HILUnresolvedReference
    minify {
      css  = local.minify.css
      html = local.minify.html
      js   = local.minify.js
    }

    //noinspection HILUnresolvedReference
    mobile_redirect {
      mobile_subdomain = var.mobile_redirect.mobile_subdomain
      status           = local.mobile_redirect.status
      strip_uri        = local.mobile_redirect.strip_uri
    }

    security_header {
      enabled            = var.security_header.enabled
      preload            = var.security_header.preload
      max_age            = var.security_header.max_age
      include_subdomains = var.security_header.include_subdomains
      nosniff            = var.security_header.nosniff
    }
  }
}

# cloudflare_zone_dnssec resource

resource "cloudflare_zone_dnssec" "this" {
  count = var.enable_dnssec ? 1 : 0

  zone_id = cloudflare_zone.this.id
}

# cloudflare_record resource

locals {
  records = defaults(var.records, {
    name    = "@"
    ttl     = 1
    proxied = false
  })
}

//noinspection HILUnresolvedReference
resource "cloudflare_record" "this" {
  for_each = var.records != null ? { for record in local.records : record.record_name => record } : {}

  zone_id = cloudflare_zone.this.id

  type = each.value.type
  name = each.value.name
  //noinspection ConflictingProperties
  value = each.value.value

  //noinspection ConflictingProperties,HILUnresolvedReference
  dynamic "data" {
    for_each = each.value.value == null && each.value.data != null ? [1] : []

    //noinspection HILUnresolvedReference
    content {
      algorithm      = each.value.data["algorithm"]
      altitude       = each.value.data["altitude"]
      certificate    = each.value.data["certificate"]
      content        = each.value.data["content"]
      digest         = each.value.data["digest"]
      digest_type    = each.value.data["digest_type"]
      fingerprint    = each.value.data["fingerprint"]
      flags          = each.value.data["flags"]
      key_tag        = each.value.data["key_tag"]
      lat_degrees    = each.value.data["lat_degrees"]
      lat_direction  = each.value.data["lat_direction"]
      lat_minutes    = each.value.data["lat_minutes"]
      lat_seconds    = each.value.data["lat_seconds"]
      long_degrees   = each.value.data["long_degrees"]
      long_direction = each.value.data["long_direction"]
      long_minutes   = each.value.data["long_minutes"]
      long_seconds   = each.value.data["long_seconds"]
      matching_type  = each.value.data["matching_type"]
      name           = each.value.data["name"]
      order          = each.value.data["order"]
      port           = each.value.data["port"]
      precision_horz = each.value.data["precision_horz"]
      precision_vert = each.value.data["precision_vert"]
      preference     = each.value.data["preference"]
      priority       = each.value.data["priority"]
      proto          = each.value.data["proto"]
      protocol       = each.value.data["protocol"]
      public_key     = each.value.data["public_key"]
      regex          = each.value.data["regex"]
      replacement    = each.value.data["replacement"]
      selector       = each.value.data["selector"]
      service        = each.value.data["service"]
      size           = each.value.data["size"]
      tag            = each.value.data["tag"]
      target         = each.value.data["target"]
      type           = each.value.data["type"]
      usage          = each.value.data["usage"]
      value          = each.value.data["value"]
      weight         = each.value.data["weight"]
    }
  }

  priority = each.value.priority
  ttl      = contains(["A", "AAAA", "CNAME"], each.value.type) && each.value.proxied == true ? 1 : each.value.ttl
  proxied  = contains(["A", "AAAA", "CNAME"], each.value.type) && each.value.proxied == true ? length(regexall("^\\*{1}", each.value.name)) == 0 || (length(regexall("^\\*{1}", each.value.name)) > 0 && contains(local.avail_starting_with_enterprise, var.plan)) ? true : false : false
}

# cloudflare_page_rule resource

locals {
  page_rules = defaults(var.page_rules, {
    actions = {
      minify = {
        css  = "off"
        html = "off"
        js   = "off"
      }
    }
  })
}

//noinspection HILUnresolvedReference
resource "cloudflare_page_rule" "this" {
  for_each = var.page_rules != null ? { for page_rule in local.page_rules : page_rule.page_rule_name => page_rule } : {}

  zone_id = cloudflare_zone.this.id

  target = each.value.target
  //noinspection HILUnresolvedReference
  actions {
    always_online            = each.value.actions["always_online"]
    always_use_https         = each.value.actions["always_use_https"]
    automatic_https_rewrites = each.value.actions["automatic_https_rewrites"]
    browser_cache_ttl        = each.value.actions["browser_cache_ttl"]
    browser_check            = each.value.actions["browser_check"]
    bypass_cache_on_cookie   = each.value.actions["bypass_cache_on_cookie"]
    cache_by_device_type     = each.value.actions["cache_by_device_type"]
    cache_deception_armor    = each.value.actions["cache_deception_armor"]

    //noinspection HILUnresolvedReference
    dynamic "cache_key_fields" {
      for_each = each.value.actions["cache_key_fields"] != null && contains(local.avail_starting_with_enterprise, var.plan) ? [1] : []

      content {
        //noinspection HILUnresolvedReference
        cookie {
          check_presence = try(each.value.actions["cache_key_fields"]["cookie"]["check_presence"], null)
          include        = try(each.value.actions["cache_key_fields"]["cookie"]["include"], null)
        }
        //noinspection HILUnresolvedReference
        header {
          check_presence = try(each.value.actions["cache_key_fields"]["header"]["check_presence"], null)
          exclude        = try(each.value.actions["cache_key_fields"]["header"]["exclude"], null)
          include        = try(each.value.actions["cache_key_fields"]["header"]["include"], null)
        }
        //noinspection HILUnresolvedReference
        host {
          resolved = try(each.value.actions["cache_key_fields"]["host"]["resolved"], null)
        }
        //noinspection HILUnresolvedReference
        query_string {
          exclude = try(each.value.actions["cache_key_fields"]["query_string"]["exclude"], null)
          include = try(each.value.actions["cache_key_fields"]["query_string"]["include"], null)
          ignore  = try(each.value.actions["cache_key_fields"]["query_string"]["ignore"], null)
        }
        //noinspection HILUnresolvedReference
        user {
          device_type = try(each.value.actions["cache_key_fields"]["user"]["device_type"], null)
          geo         = try(each.value.actions["cache_key_fields"]["user"]["geo"], null)
          lang        = try(each.value.actions["cache_key_fields"]["user"]["lang"], null)
        }
      }
    }

    cache_level     = each.value.actions["cache_level"]
    cache_on_cookie = each.value.actions["cache_on_cookie"]

    //noinspection HILUnresolvedReference
    dynamic "cache_ttl_by_status" {
      for_each = each.value.actions["cache_ttl_by_status"] != null && contains(local.avail_starting_with_enterprise, var.plan) ? each.value.actions["cache_ttl_by_status"][*] : []

      //noinspection HILUnresolvedReference
      content {
        codes = try(each.value.actions["cache_ttl_by_status"][cache_ttl_by_status.key]["codes"], null)
        ttl   = try(each.value.actions["cache_ttl_by_status"][cache_ttl_by_status.key]["ttl"], null)
      }
    }

    disable_apps           = each.value.actions["disable_apps"]
    disable_performance    = each.value.actions["disable_performance"]
    disable_railgun        = each.value.actions["disable_railgun"]
    disable_security       = each.value.actions["disable_security"]
    disable_zaraz          = each.value.actions["disable_zaraz"]
    edge_cache_ttl         = each.value.actions["edge_cache_ttl"]
    email_obfuscation      = each.value.actions["email_obfuscation"]
    explicit_cache_control = each.value.actions["explicit_cache_control"]

    //noinspection HILUnresolvedReference
    dynamic "forwarding_url" {
      for_each = each.value.actions["forwarding_url"] != null ? [1] : []

      //noinspection HILUnresolvedReference
      content {
        status_code = try(each.value.actions["forwarding_url"]["status_code"], null)
        url         = try(each.value.actions["forwarding_url"]["url"], null)
      }
    }

    host_header_override = each.value.actions["host_header_override"]
    ip_geolocation       = each.value.actions["ip_geolocation"]

    //noinspection HILUnresolvedReference
    dynamic "minify" {
      for_each = each.value.actions["minify"] != null ? [1] : []

      //noinspection HILUnresolvedReference
      content {
        html = each.value.actions["minify"]["html"]
        css  = each.value.actions["minify"]["css"]
        js   = each.value.actions["minify"]["js"]
      }
    }

    mirage                      = contains(local.mirage_avail, var.plan) ? each.value.actions["mirage"] : null
    opportunistic_encryption    = each.value.actions["opportunistic_encryption"]
    origin_error_page_pass_thru = contains(local.origin_error_page_pass_thru_avail, var.plan) ? each.value.actions["origin_error_page_pass_thru"] : null
    polish                      = contains(local.polish_avail, var.plan) ? each.value.actions["polish"] : null
    resolve_override            = each.value.actions["resolve_override"]
    respect_strong_etag         = each.value.actions["respect_strong_etag"]
    response_buffering          = contains(local.response_buffering_avail, var.plan) ? each.value.actions["response_buffering"] : null
    rocket_loader               = each.value.actions["rocket_loader"]
    security_level              = try(contains(local.security_level_avail_values, each.value.actions["security_level"]), false) ? each.value.actions["security_level"] : local.security_level_closest_avail_values[var.plan]
    server_side_exclude         = each.value.actions["server_side_exclude"]
    #    Unsupported argument, see https://github.com/cloudflare/terraform-provider-cloudflare/issues/1544
    #    smart_errors                = each.value.actions["smart_errors"]
    sort_query_string_for_cache = contains(local.sort_query_string_for_cache_avail, var.plan) ? each.value.actions["sort_query_string_for_cache"] : null
    ssl                         = each.value.actions["ssl"]
    true_client_ip_header       = contains(local.true_client_ip_header_avail, var.plan) ? each.value.actions["true_client_ip_header"] : null
    waf                         = contains(local.waf_avail, var.plan) ? each.value.actions["waf"] : null
  }
  priority = each.value.priority
  status   = each.value.status
}
