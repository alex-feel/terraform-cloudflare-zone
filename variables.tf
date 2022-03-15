# Required

variable "zone" {
  type        = string
  description = "The DNS zone name which will be added, e.g. example.com."
}

# Optional

variable "paused" {
  type        = bool
  description = "Indicates if the zone is only using Cloudflare DNS services. A true value means the zone will not receive security or performance benefits."
  default     = false
}

variable "jump_start" {
  type        = bool
  description = "Automatically attempt to fetch existing DNS records on creation. Ignored after zone is created."
  default     = false
}

variable "plan" {
  type        = string
  description = "The desired plan for the zone. Can be updated once the one is created. One of free, pro, business, enterprise, partners_free, partners_pro, partners_business, partners_enterprise. Changing this value will create/cancel associated subscriptions."
  default     = "free"

  validation {
    condition     = contains(["free", "pro", "business", "enterprise", "partners_free", "partners_pro", "partners_business", "partners_enterprise"], var.plan)
    error_message = "The plan value must be one of the following: \"free\", \"pro\", \"business\", \"enterprise\", \"partners_free\", \"partners_pro\", \"partners_business\", \"partners_enterprise\"."
  }
}

variable "type" {
  type        = string
  description = "A full zone implies that DNS is hosted with Cloudflare. A partial zone is typically a partner-hosted zone or a CNAME setup. Valid values: full, partial."
  default     = "full"

  validation {
    condition     = contains(["full", "partial"], var.type)
    error_message = "The type value must be one of the following: \"full\", \"partial\"."
  }
}

variable "always_online" {
  type        = string
  description = "When enabled, Always Online will serve pages from our cache if your server is offline."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.always_online)
    error_message = "The always_online value must be one of the following: \"off\", \"on\"."
  }
}

variable "always_use_https" {
  type        = string
  description = "Reply to all requests for URLs that use 'http' with a 301 redirect to the equivalent 'https' URL. If you only want to redirect for a subset of requests, consider creating an 'Always use HTTPS' page rule."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.always_use_https)
    error_message = "The always_use_https value must be one of the following: \"off\", \"on\"."
  }
}

variable "automatic_https_rewrites" {
  type        = string
  description = "Enable the Automatic HTTPS Rewrites feature for this zone."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.automatic_https_rewrites)
    error_message = "The automatic_https_rewrites value must be one of the following: \"off\", \"on\"."
  }
}

variable "brotli" {
  type        = string
  description = "When the client requesting an asset supports the brotli compression algorithm, Cloudflare will serve a brotli compressed version of the asset."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.brotli)
    error_message = "The brotli value must be one of the following: \"off\", \"on\"."
  }
}

variable "browser_check" {
  type        = string
  description = "Browser Integrity Check is similar to Bad Behavior and looks for common HTTP headers abused most commonly by spammers and denies access to your page. It will also challenge visitors that do not have a user agent or a non standard user agent (also commonly used by abuse bots, crawlers or visitors)."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.browser_check)
    error_message = "The browser_check value must be one of the following: \"off\", \"on\"."
  }
}

variable "development_mode" {
  type        = string
  description = "Development Mode temporarily allows you to enter development mode for your websites if you need to make changes to your site. This will bypass Cloudflare's accelerated cache and slow down your site, but is useful if you are making changes to cacheable content (like images, css, or JavaScript) and would like to see those changes right away. Once entered, development mode will last for 3 hours and then automatically toggle off."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.development_mode)
    error_message = "The development_mode value must be one of the following: \"off\", \"on\"."
  }
}

variable "early_hints" {
  type        = string
  description = "When enabled, Cloudflare will attempt to speed up overall page loads by serving 103 responses with Link headers from the final response (https://developers.cloudflare.com/cache/about/early-hints)."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.early_hints)
    error_message = "The early_hints value must be one of the following: \"off\", \"on\"."
  }
}

variable "email_obfuscation" {
  type        = string
  description = "Encrypt email adresses on your web page from bots, while keeping them visible to humans."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.email_obfuscation)
    error_message = "The email_obfuscation value must be one of the following: \"off\", \"on\"."
  }
}

variable "hotlink_protection" {
  type        = string
  description = "When enabled, the Hotlink Protection option ensures that other sites cannot suck up your bandwidth by building pages that use images hosted on your site. Anytime a request for an image on your site hits Cloudflare, we check to ensure that it's not another site requesting them. People will still be able to download and view images from your page, but other sites won't be able to steal them for use on their own pages."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.hotlink_protection)
    error_message = "The hotlink_protection value must be one of the following: \"off\", \"on\"."
  }
}

variable "http2" {
  type        = string
  description = "HTTP2 setting."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.http2)
    error_message = "The http2 value must be one of the following: \"off\", \"on\"."
  }
}

variable "http3" {
  type        = string
  description = "HTTP3 setting."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.http3)
    error_message = "The http3 value must be one of the following: \"off\", \"on\"."
  }
}

variable "ip_geolocation" {
  type        = string
  description = "Enable IP Geolocation to have Cloudflare geolocate visitors to your website and pass the country code to you."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.ip_geolocation)
    error_message = "The ip_geolocation value must be one of the following: \"off\", \"on\"."
  }
}

variable "ipv6" {
  type        = string
  description = "Enable IPv6 on all subdomains that are Cloudflare enabled."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.ipv6)
    error_message = "The ipv6 value must be one of the following: \"off\", \"on\"."
  }
}

variable "mirage" {
  type        = string
  description = "Automatically optimize image loading for website visitors on mobile devices."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.mirage)
    error_message = "The mirage value must be one of the following: \"off\", \"on\"."
  }
}

variable "opportunistic_encryption" {
  type        = string
  description = "Enable the Opportunistic Encryption feature for this zone."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.opportunistic_encryption)
    error_message = "The opportunistic_encryption value must be one of the following: \"off\", \"on\"."
  }
}

variable "opportunistic_onion" {
  type        = string
  description = "Add an Alt-Svc header to all legitimate requests from Tor, allowing the connection to use our onion services instead of exit nodes."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.opportunistic_onion)
    error_message = "The opportunistic_onion value must be one of the following: \"off\", \"on\"."
  }
}

variable "orange_to_orange" {
  type        = string
  description = "Orange to Orange (O2O) allows zones on Cloudflare to CNAME to other zones also on Cloudflare."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.orange_to_orange)
    error_message = "The orange_to_orange value must be one of the following: \"off\", \"on\"."
  }
}

variable "origin_error_page_pass_thru" {
  type        = string
  description = "Cloudflare will proxy customer error pages on any 502,504 errors on origin server instead of showing a default Cloudflare error page. This does not apply to 522 errors and is limited to Enterprise Zones."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.origin_error_page_pass_thru)
    error_message = "The origin_error_page_pass_thru value must be one of the following: \"off\", \"on\"."
  }
}

variable "prefetch_preload" {
  type        = string
  description = "Cloudflare will prefetch any URLs that are included in the response headers. This is limited to Enterprise Zones."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.prefetch_preload)
    error_message = "The prefetch_preload value must be one of the following: \"off\", \"on\"."
  }
}

variable "privacy_pass" {
  type        = string
  description = "Privacy Pass is a browser extension developed by the Privacy Pass Team to improve the browsing experience for your visitors. Enabling Privacy Pass will reduce the number of CAPTCHAs shown to your visitors."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.privacy_pass)
    error_message = "The privacy_pass value must be one of the following: \"off\", \"on\"."
  }
}

variable "response_buffering" {
  type        = string
  description = "Enables or disables buffering of responses from the proxied server. Cloudflare may buffer the whole payload to deliver it at once to the client versus allowing it to be delivered in chunks. By default, the proxied server streams directly and is not buffered by Cloudflare. This is limited to Enterprise Zones."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.response_buffering)
    error_message = "The response_buffering value must be one of the following: \"off\", \"on\"."
  }
}

variable "rocket_loader" {
  type        = string
  description = "Rocket Loader is a general-purpose asynchronous JavaScript optimisation which prioritises the rendering of your content while loading your site's Javascript asynchronously. Turning on Rocket Loader will immediately improve a web page's rendering time sometimes measured as Time to First Paint (TTFP) and also the window.onload time (assuming there is JavaScript on the page), which can have a positive impact on your Google search ranking. When turned on, Rocket Loader will automatically defer the loading of all Javascript referenced in your HTML, with no configuration required."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.rocket_loader)
    error_message = "The rocket_loader value must be one of the following: \"off\", \"on\"."
  }
}

variable "server_side_exclude" {
  type        = string
  description = "If there is sensitive content on your website that you want visible to real visitors, but that you want to hide from suspicious visitors, all you have to do is wrap the content with Cloudflare SSE tags. Wrap any content that you want to be excluded from suspicious visitors in the following SSE tags: <!--sse--><!--/sse-->. For example: <!--sse--> Bad visitors won't see my phone number, 555-555-5555 <!--/sse-->. Note: SSE only will work with HTML. If you have HTML minification enabled, you won't see the SSE tags in your HTML source when it's served through Cloudflare. SSE will still function in this case, as Cloudflare's HTML minification and SSE functionality occur on-the-fly as the resource moves through our network to the visitor's computer."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.server_side_exclude)
    error_message = "The server_side_exclude value must be one of the following: \"off\", \"on\"."
  }
}

variable "sort_query_string_for_cache" {
  type        = string
  description = "Cloudflare will treat files with the same query strings as the same file in cache, regardless of the order of the query strings. This is limited to Enterprise Zones."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.sort_query_string_for_cache)
    error_message = "The sort_query_string_for_cache value must be one of the following: \"off\", \"on\"."
  }
}

variable "tls_client_auth" {
  type        = string
  description = "TLS Client Auth requires Cloudflare to connect to your origin server using a client certificate (Enterprise Only)."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.tls_client_auth)
    error_message = "The tls_client_auth value must be one of the following: \"off\", \"on\"."
  }
}

variable "true_client_ip_header" {
  type        = string
  description = "Allows customer to continue to use True Client IP (Akamai feature) in the headers we send to the origin. This is limited to Enterprise Zones."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.true_client_ip_header)
    error_message = "The true_client_ip_header value must be one of the following: \"off\", \"on\"."
  }
}

variable "universal_ssl" {
  type        = string
  description = "Disabling Universal SSL removes any currently active Universal SSL certificates for your zone from the edge and prevents any future Universal SSL certificates from being ordered. If there are no dedicated certificates or custom certificates uploaded for the domain, visitors will be unable to access the domain over HTTPS."
  default     = "on"

  validation {
    condition     = contains(["off", "on"], var.universal_ssl)
    error_message = "The universal_ssl value must be one of the following: \"off\", \"on\"."
  }
}

variable "waf" {
  type        = string
  description = "The WAF examines HTTP requests to your website. It inspects both GET and POST requests and applies rules to help filter out illegitimate traffic from legitimate website visitors. The Cloudflare WAF inspects website addresses or URLs to detect anything out of the ordinary. If the Cloudflare WAF determines suspicious user behavior, then the WAF will 'challenge' the web visitor with a page that asks them to submit a CAPTCHA successfully to continue their action. If the challenge is failed, the action will be stopped. What this means is that Cloudflare's WAF will block any traffic identified as illegitimate before it reaches your origin web server."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.waf)
    error_message = "The waf value must be one of the following: \"off\", \"on\"."
  }
}

variable "webp" {
  type        = string
  description = "When the client requesting the image supports the WebP image codec, Cloudflare will serve a WebP version of the image when WebP offers a performance advantage over the original image format. Note that the value specified will be ignored unless polish is turned on (i.e. is \"lossless\" or \"lossy\")."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.webp)
    error_message = "The webp value must be one of the following: \"off\", \"on\"."
  }
}

variable "websockets" {
  type        = string
  description = "WebSockets are open connections sustained between the client and the origin server. Inside a WebSockets connection, the client and the origin can pass data back and forth without having to reestablish sessions. This makes exchanging data within a WebSockets connection fast. WebSockets are often used for real-time applications such as live chat and gaming."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.websockets)
    error_message = "The websockets value must be one of the following: \"off\", \"on\"."
  }
}

variable "zero_rtt" {
  type        = string
  description = "0-RTT setting."
  default     = "off"

  validation {
    condition     = contains(["off", "on"], var.zero_rtt)
    error_message = "The zero_rtt value must be one of the following: \"off\", \"on\"."
  }
}

variable "cache_level" {
  type        = string
  description = "Cache Level functions based off the setting level. The basic setting will cache most static resources (i.e., css, images, and JavaScript). The simplified setting will ignore the query string when delivering a cached resource. The aggressive setting will cache all static resources, including ones with a query string."
  default     = "aggressive"

  validation {
    condition     = contains(["aggressive", "basic", "simplified"], var.cache_level)
    error_message = "The cache_level value must be one of the following: \"aggressive\", \"basic\", \"simplified\"."
  }
}

variable "cname_flattening" {
  type        = string
  description = "CNAME flattening setting."
  default     = "flatten_at_root"

  validation {
    condition     = contains(["flatten_at_root", "flatten_all", "flatten_none"], var.cname_flattening)
    error_message = "The cname_flattening value must be one of the following: \"flatten_at_root\", \"flatten_all\", \"flatten_none\"."
  }
}

variable "h2_prioritization" {
  type        = string
  description = "HTTP/2 Edge Prioritization optimises the delivery of resources served through HTTP/2 to improve page load performance. It also supports fine control of content delivery when used in conjunction with Workers."
  default     = "off"

  validation {
    condition     = contains(["off", "on", "custom"], var.h2_prioritization)
    error_message = "The h2_prioritization value must be one of the following: \"off\", \"on\", \"custom\"."
  }
}

variable "image_resizing" {
  type        = string
  description = "Image Resizing provides on-demand resizing, conversion and optimisation for images served through Cloudflare's network."
  default     = "off"

  validation {
    condition     = contains(["off", "on", "open"], var.image_resizing)
    error_message = "The image_resizing value must be one of the following: \"off\", \"on\", \"open\"."
  }
}

variable "min_tls_version" {
  type        = string
  description = "Only accept HTTPS requests that use at least the TLS protocol version specified. For example, if TLS 1.1 is selected, TLS 1.0 connections will be rejected, while 1.1, 1.2, and 1.3 (if enabled) will be permitted."
  default     = "1.0"

  validation {
    condition     = contains(["1.0", "1.1", "1.2", "1.3"], var.min_tls_version)
    error_message = "The min_tls_version value must be one of the following: \"1.0\", \"1.1\", \"1.2\", \"1.3\"."
  }
}

variable "polish" {
  type        = string
  description = "Strips metadata and compresses your images for faster page load times. Basic (Lossless): Reduce the size of PNG, JPEG, and GIF files - no impact on visual quality. Basic + JPEG (Lossy): Further reduce the size of JPEG files for faster image loading. Larger JPEGs are converted to progressive images, loading a lower-resolution image first and ending in a higher-resolution version. Not recommended for hi-res photography sites."
  default     = "off"

  validation {
    condition     = contains(["off", "lossless", "lossy"], var.polish)
    error_message = "The polish value must be one of the following: \"off\", \"lossless\", \"lossy\"."
  }
}

variable "proxy_read_timeout" {
  type        = number
  description = "Maximum time between two read operations from origin."
  default     = 100

  validation {
    condition     = var.proxy_read_timeout >= 1 && var.proxy_read_timeout <= 6000
    error_message = "The proxy_read_timeout value must be between 1 and 6000."
  }
}

variable "pseudo_ipv4" {
  type        = string
  description = "Pseudo IPv4 setting."
  default     = "off"

  validation {
    condition     = contains(["off", "add_header", "overwrite_header"], var.pseudo_ipv4)
    error_message = "The pseudo_ipv4 value must be one of the following: \"off\", \"add_header\", \"overwrite_header\"."
  }
}

variable "security_level" {
  type        = string
  description = "Choose the appropriate security profile for your website, which will automatically adjust each of the security settings. If you choose to customize an individual security setting, the profile will become Custom."
  default     = "medium"

  validation {
    condition     = contains(["off", "essentially_off", "low", "medium", "high", "under_attack"], var.security_level)
    error_message = "The security_level value must be one of the following: \"off\", \"essentially_off\", \"low\", \"medium\", \"high\", \"under_attack\"."
  }
}

variable "ssl" {
  type        = string
  description = "SSL encrypts your visitor's connection and safeguards credit card numbers and other personal data to and from your website. SSL can take up to 5 minutes to fully activate. Requires Cloudflare active on your root domain or www domain. Off: no SSL between the visitor and Cloudflare, and no SSL between Cloudflare and your web server (all HTTP traffic). Flexible: SSL between the visitor and Cloudflare -- visitor sees HTTPS on your site, but no SSL between Cloudflare and your web server. You don't need to have an SSL cert on your web server, but your vistors will still see the site as being HTTPS enabled. Full: SSL between the visitor and Cloudflare -- visitor sees HTTPS on your site, and SSL between Cloudflare and your web server. You'll need to have your own SSL cert or self-signed cert at the very least. Full (Strict): SSL between the visitor and Cloudflare -- visitor sees HTTPS on your site, and SSL between Cloudflare and your web server. You'll need to have a valid SSL certificate installed on your web server. This certificate must be signed by a certificate authority, have an expiration date in the future, and respond for the request domain name (hostname)."
  default     = "off"

  validation {
    condition     = contains(["off", "flexible", "full", "strict"], var.ssl)
    error_message = "The ssl value must be one of the following: \"off\", \"flexible\", \"full\", \"strict\"."
  }
}

variable "tls_1_3" {
  type        = string
  description = "Enable Crypto TLS 1.3 feature for this zone."
  default     = "off"

  validation {
    condition     = contains(["off", "on", "zrt"], var.tls_1_3)
    error_message = "The tls_1_3 value must be one of the following: \"off\", \"on\", \"zrt\"."
  }
}

variable "browser_cache_ttl" {
  type        = number
  description = "Browser Cache TTL (in seconds) specifies how long Cloudflare-cached resources will remain on your visitors' computers. Cloudflare will honor any larger times specified by your server. Setting a TTL of 0 is equivalent to selecting `Respect Existing Headers`."
  default     = 14400

  validation {
    condition     = contains([0, 30, 60, 300, 1200, 1800, 3600, 7200, 10800, 14400, 18000, 28800, 43200, 57600, 72000, 86400, 172800, 259200, 345600, 432000, 691200, 1382400, 2073600, 2678400, 5356800, 16070400, 31536000], var.browser_cache_ttl)
    error_message = "The browser_cache_ttl value must be one of the following: 0, 30, 60, 300, 1200, 1800, 3600, 7200, 10800, 14400, 18000, 28800, 43200, 57600, 72000, 86400, 172800, 259200, 345600, 432000, 691200, 1382400, 2073600, 2678400, 5356800, 16070400, 31536000."
  }
}

variable "challenge_ttl" {
  type        = number
  description = "Specify how long a visitor is allowed access to your site after successfully completing a challenge (such as a CAPTCHA). After the TTL has expired the visitor will have to complete a new challenge. We recommend a 15 - 45 minute setting and will attempt to honor any setting above 45 minutes."
  default     = 1800

  validation {
    condition     = contains([300, 900, 1800, 2700, 3600, 7200, 10800, 14400, 28800, 57600, 86400, 604800, 2592000, 31536000], var.challenge_ttl)
    error_message = "The challenge_ttl value must be one of the following: 300, 900, 1800, 2700, 3600, 7200, 10800, 14400, 28800, 57600, 86400, 604800, 2592000, 31536000."
  }
}

variable "max_upload" {
  type        = number
  description = "The amount of data visitors can upload to your website in a single request."
  default     = 100

  validation {
    condition     = contains([100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500], var.max_upload)
    error_message = "The max_upload value must be one of the following: 100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500."
  }
}

variable "minify" {
  type = object({
    css  = optional(string)
    html = optional(string)
    js   = optional(string)
  })
  description = "Automatically minify certain assets for your website."
  default = {
    css  = "off"
    html = "off"
    js   = "off"
  }

  validation {
    condition     = try(contains(["off", "on"], var.minify.css), true) && try(contains(["off", "on"], var.minify.html), true) && try(contains(["off", "on"], var.minify.js), true)
    error_message = "The minify.css, minify.html, minify.js values must be one of the following: \"off\", \"on\"."
  }
}

variable "mobile_redirect" {
  type = object({
    mobile_subdomain = string
    status           = optional(string)
    strip_uri        = optional(bool)
  })
  description = "Automatically redirect visitors on mobile devices to a mobile-optimized subdomain."
  default = {
    mobile_subdomain = ""
    status           = "off"
    strip_uri        = false
  }

  validation {
    condition     = try(contains(["off", "on"], var.mobile_redirect.status), true) && try((length(var.mobile_redirect.mobile_subdomain) >= 1 || var.mobile_redirect.status == "off" && var.mobile_redirect.mobile_subdomain == ""), true)
    error_message = "The mobile_redirect.status value must be one of the following: \"off\", \"on\", the mobile_redirect.mobile_subdomain value must have a minimum length of 1."
  }
}

variable "security_header" {
  type = object({
    enabled            = optional(bool)
    preload            = optional(bool)
    max_age            = optional(number)
    include_subdomains = optional(bool)
    nosniff            = optional(bool)
  })
  description = "Cloudflare security headers for a zone."
  default = {
    enabled            = true
    preload            = false
    max_age            = 86400
    include_subdomains = true
    nosniff            = true
  }

  validation {
    # Not sure if the values for var.security_header.max_age are valid
    condition     = try(contains([0, 30, 60, 300, 1200, 1800, 3600, 7200, 10800, 14400, 18000, 28800, 43200, 57600, 72000, 86400, 172800, 259200, 345600, 432000, 691200, 1382400, 2073600, 2678400, 5356800, 16070400, 31536000], var.security_header.max_age), true)
    error_message = "The var.security_header.max_age value must be one of the following: 0, 30, 60, 300, 1200, 1800, 3600, 7200, 10800, 14400, 18000, 28800, 43200, 57600, 72000, 86400, 172800, 259200, 345600, 432000, 691200, 1382400, 2073600, 2678400, 5356800, 16070400, 31536000."
  }
}

variable "enable_dnssec" {
  type        = bool
  description = "Enable or disable DNSSEC."
  default     = false
}

variable "records" {
  type = list(object({
    record_name = string
    type        = string
    name        = optional(string)
    value       = string
    priority    = optional(number)
    ttl         = optional(number)
    proxied     = optional(bool)
  }))
  description = "Zone's DNS records."
  default     = []

  validation {
    condition     = alltrue([for i in var.records : try(contains(["A", "AAAA", "CAA", "CERT", "CNAME", "DNSKEY", "DS", "HTTPS", "LOC", "MX", "NAPTR", "NS", "PTR", "SMIMEA", "SPF", "SRV", "SSHFP", "SVCB", "TLSA", "TXT", "URI"], i.type), true)]) && alltrue([for i in var.records : try(i.priority >= 0 && i.priority <= 65535, true)]) && alltrue([for i in var.records : try(contains([1, 120, 300, 600, 900, 1800, 3600, 7200, 18000, 43200, 86400], i.ttl), true)])
    error_message = "All the records[*].type values must be one of the following: \"A\", \"AAAA\", \"CAA\", \"CERT\", \"CNAME\", \"DNSKEY\", \"DS\", \"HTTPS\", \"LOC\", \"MX\", \"NAPTR\", \"NS\", \"PTR\", \"SMIMEA\", \"SPF\", \"SRV\", \"SSHFP\", \"SVCB\", \"TLSA\", \"TXT\", \"URI\", all the records[*].priority values must be between 0 and 65535, all the records[*].ttl values must be one of the following: 1, 120, 300, 600, 900, 1800, 3600, 7200, 18000, 43200, 86400."
  }
}
