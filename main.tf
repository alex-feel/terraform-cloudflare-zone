terraform {
  # The module functionality uses the defaults function, more details in https://www.terraform.io/language/functions/defaults
  experiments = [module_variable_optional_attrs]
}

# List of plans that affect the availability of settings
locals {
  avail_starting_with_pro        = ["pro", "partners_pro", "business", "partners_business", "enterprise", "partners_enterprise"]
  avail_starting_with_business   = ["business", "partners_business", "enterprise", "partners_enterprise"]
  avail_starting_with_enterprise = ["enterprise", "partners_enterprise"]
}

# Common data sources

# The nearest available values for the case when the value specified in the configuration is not available
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

# The nearest available values for the case when the value specified in the configuration is not available
locals {
  max_upload_closest_avail_values = {
    "free"              = 100
    "pro"               = 100
    "partners_pro"      = 100
    "business"          = 200
    "partners_business" = 200
  }
}

# Availability of cloudflare_zone_settings_override resource settings or their values on the current plan
locals {
  cloudflare_zone_settings_override_avail = {
    cname_flattening            = contains(local.avail_starting_with_pro, var.plan) ? true : false
    h2_prioritization           = contains(local.avail_starting_with_pro, var.plan) ? true : false
    http2                       = contains(local.avail_starting_with_pro, var.plan) ? true : false
    http3                       = contains(local.avail_starting_with_pro, var.plan) ? true : false
    image_resizing              = contains(local.avail_starting_with_business, var.plan) ? true : false
    ipv6                        = contains(local.avail_starting_with_pro, var.plan) ? true : false
    max_upload                  = contains(local.avail_starting_with_enterprise, var.plan) ? [100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500] : contains(local.avail_starting_with_business, var.plan) ? [100, 125, 150, 175, 200] : [100]
    mirage                      = contains(local.avail_starting_with_pro, var.plan) ? true : false
    orange_to_orange            = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    origin_error_page_pass_thru = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    polish                      = contains(local.avail_starting_with_pro, var.plan) ? true : false
    prefetch_preload            = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    proxy_read_timeout          = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    pseudo_ipv4                 = contains(local.avail_starting_with_pro, var.plan) ? true : false
    response_buffering          = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    security_level              = contains(local.avail_starting_with_enterprise, var.plan) ? ["off", "essentially_off", "low", "medium", "high", "under_attack"] : ["essentially_off", "low", "medium", "high", "under_attack"]
    sort_query_string_for_cache = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    tls_client_auth             = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    true_client_ip_header       = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    waf                         = contains(local.avail_starting_with_pro, var.plan) ? true : false
    webp                        = contains(local.avail_starting_with_pro, var.plan) ? true : false
    zero_rtt                    = contains(local.avail_starting_with_pro, var.plan) ? true : false
  }
}

# Assigning default values for arguments that have no value in the configuration
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
    always_online            = var.always_online
    always_use_https         = var.always_use_https
    automatic_https_rewrites = var.automatic_https_rewrites
    brotli                   = var.brotli
    browser_cache_ttl        = var.browser_cache_ttl
    browser_check            = var.browser_check
    cache_level              = var.cache_level
    challenge_ttl            = var.challenge_ttl
    # At the moment, it is not possible to automatically ignore this option without errors if you do not have the Advanced Certificate Manager plan subscription, as there is no data source that allows you to get the subscription status
    ciphers            = var.ciphers
    cname_flattening   = local.cloudflare_zone_settings_override_avail.cname_flattening ? var.cname_flattening : null
    development_mode   = var.development_mode
    early_hints        = var.early_hints
    email_obfuscation  = var.email_obfuscation
    h2_prioritization  = local.cloudflare_zone_settings_override_avail.h2_prioritization ? var.h2_prioritization : null
    hotlink_protection = var.hotlink_protection
    http2              = local.cloudflare_zone_settings_override_avail.http2 ? var.http2 : null
    http3              = local.cloudflare_zone_settings_override_avail.http3 ? var.http3 : null
    image_resizing     = local.cloudflare_zone_settings_override_avail.image_resizing ? var.image_resizing : null
    ip_geolocation     = var.ip_geolocation
    ipv6               = local.cloudflare_zone_settings_override_avail.ipv6 ? var.ipv6 : null
    max_upload         = contains(local.cloudflare_zone_settings_override_avail.max_upload, var.max_upload) ? var.max_upload : local.max_upload_closest_avail_values[var.plan]
    min_tls_version    = var.min_tls_version

    //noinspection HILUnresolvedReference
    minify {
      css  = local.minify.css
      html = local.minify.html
      js   = local.minify.js
    }

    mirage = local.cloudflare_zone_settings_override_avail.mirage ? var.mirage : null

    //noinspection HILUnresolvedReference
    mobile_redirect {
      mobile_subdomain = var.mobile_redirect.mobile_subdomain
      status           = local.mobile_redirect.status
      strip_uri        = local.mobile_redirect.strip_uri
    }

    opportunistic_encryption    = var.opportunistic_encryption
    opportunistic_onion         = var.opportunistic_onion
    orange_to_orange            = local.cloudflare_zone_settings_override_avail.orange_to_orange ? var.orange_to_orange : null
    origin_error_page_pass_thru = local.cloudflare_zone_settings_override_avail.origin_error_page_pass_thru ? var.origin_error_page_pass_thru : null
    # Since `polish` and `webp` are available on the same plan, it is not necessary to check if `webp` is available when `polish` is definitely available, so we can just use `var.webp` in the expression
    polish             = local.cloudflare_zone_settings_override_avail.polish ? (var.polish == null || var.polish == "off") && var.webp == "on" ? "lossless" : var.polish : null
    prefetch_preload   = local.cloudflare_zone_settings_override_avail.prefetch_preload ? var.prefetch_preload : null
    privacy_pass       = var.privacy_pass
    proxy_read_timeout = local.cloudflare_zone_settings_override_avail.proxy_read_timeout ? var.proxy_read_timeout : null
    pseudo_ipv4        = local.cloudflare_zone_settings_override_avail.pseudo_ipv4 ? var.pseudo_ipv4 : null
    response_buffering = local.cloudflare_zone_settings_override_avail.response_buffering ? var.response_buffering : null
    rocket_loader      = var.rocket_loader

    security_header {
      enabled            = var.security_header.enabled
      preload            = var.security_header.preload
      max_age            = var.security_header.max_age
      include_subdomains = var.security_header.include_subdomains
      nosniff            = var.security_header.nosniff
    }

    security_level              = contains(local.cloudflare_zone_settings_override_avail.security_level, var.security_level) ? var.security_level : local.security_level_closest_avail_values[var.plan]
    server_side_exclude         = var.server_side_exclude
    sort_query_string_for_cache = local.cloudflare_zone_settings_override_avail.sort_query_string_for_cache ? var.sort_query_string_for_cache : null
    ssl                         = var.ssl
    tls_1_3                     = var.tls_1_3
    tls_client_auth             = local.cloudflare_zone_settings_override_avail.tls_client_auth ? var.tls_client_auth : null
    true_client_ip_header       = local.cloudflare_zone_settings_override_avail.true_client_ip_header ? var.true_client_ip_header : null
    universal_ssl               = var.universal_ssl
    waf                         = local.cloudflare_zone_settings_override_avail.waf ? var.waf : null
    webp                        = local.cloudflare_zone_settings_override_avail.webp ? var.webp : null
    websockets                  = var.websockets
    zero_rtt                    = local.cloudflare_zone_settings_override_avail.zero_rtt ? var.zero_rtt : null
  }
}

# cloudflare_zone_dnssec resource

resource "cloudflare_zone_dnssec" "this" {
  count = var.enable_dnssec ? 1 : 0

  zone_id = cloudflare_zone.this.id
}

# cloudflare_record resource

# Assigning default values for arguments that have no value in the configuration
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

  name = each.value.name
  type = each.value.type
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

  ttl      = contains(["A", "AAAA", "CNAME"], each.value.type) && each.value.proxied == true ? 1 : each.value.ttl
  priority = each.value.priority
  proxied  = contains(["A", "AAAA", "CNAME"], each.value.type) && each.value.proxied == true ? length(regexall("^\\*{1}", each.value.name)) == 0 || (length(regexall("^\\*{1}", each.value.name)) > 0 && contains(local.avail_starting_with_enterprise, var.plan)) ? true : false : false
}

# cloudflare_page_rule resource

# Availability of cloudflare_page_rule resource actions or their values on the current plan
locals {
  cloudflare_page_rule_avail = {
    cache_key_fields            = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    cache_ttl_by_status         = contains(local.avail_starting_with_enterprise, var.plan) ? true : false
    mirage                      = local.cloudflare_zone_settings_override_avail.mirage
    origin_error_page_pass_thru = local.cloudflare_zone_settings_override_avail.origin_error_page_pass_thru
    polish                      = local.cloudflare_zone_settings_override_avail.polish
    response_buffering          = local.cloudflare_zone_settings_override_avail.response_buffering
    security_level              = local.cloudflare_zone_settings_override_avail.security_level
    sort_query_string_for_cache = local.cloudflare_zone_settings_override_avail.sort_query_string_for_cache
    true_client_ip_header       = local.cloudflare_zone_settings_override_avail.true_client_ip_header
    waf                         = local.cloudflare_zone_settings_override_avail.waf
  }
}

# Assigning default values for arguments that have no value in the configuration
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
      for_each = each.value.actions["cache_key_fields"] != null && local.cloudflare_page_rule_avail.cache_key_fields ? [1] : []

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
      for_each = each.value.actions["cache_ttl_by_status"] != null && local.cloudflare_page_rule_avail.cache_ttl_by_status ? each.value.actions["cache_ttl_by_status"][*] : []

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

    mirage                      = local.cloudflare_page_rule_avail.mirage ? each.value.actions["mirage"] : null
    opportunistic_encryption    = each.value.actions["opportunistic_encryption"]
    origin_error_page_pass_thru = local.cloudflare_page_rule_avail.origin_error_page_pass_thru ? each.value.actions["origin_error_page_pass_thru"] : null
    polish                      = local.cloudflare_page_rule_avail.polish ? each.value.actions["polish"] : null
    resolve_override            = each.value.actions["resolve_override"]
    respect_strong_etag         = each.value.actions["respect_strong_etag"]
    response_buffering          = local.cloudflare_page_rule_avail.response_buffering ? each.value.actions["response_buffering"] : null
    rocket_loader               = each.value.actions["rocket_loader"]
    security_level              = try(contains(local.cloudflare_page_rule_avail.security_level, each.value.actions["security_level"]), false) ? each.value.actions["security_level"] : each.value.actions["security_level"] != null ? local.security_level_closest_avail_values[var.plan] : null
    server_side_exclude         = each.value.actions["server_side_exclude"]
    #    Unsupported argument, see https://github.com/cloudflare/terraform-provider-cloudflare/issues/1544
    #    smart_errors                = each.value.actions["smart_errors"]
    sort_query_string_for_cache = local.cloudflare_page_rule_avail.sort_query_string_for_cache ? each.value.actions["sort_query_string_for_cache"] : null
    ssl                         = each.value.actions["ssl"]
    true_client_ip_header       = local.cloudflare_page_rule_avail.true_client_ip_header ? each.value.actions["true_client_ip_header"] : null
    waf                         = local.cloudflare_page_rule_avail.waf ? each.value.actions["waf"] : null
  }
  priority = each.value.priority
  status   = each.value.status
}
