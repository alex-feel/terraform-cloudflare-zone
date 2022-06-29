# Required

# cloudflare_zone resource

variable "zone" {
  type        = string
  description = "The DNS zone name which will be added, e.g. example.com."
}

# Optional

# cloudflare_zone resource

variable "paused" {
  type        = bool
  description = "Indicates if the zone is only using Cloudflare DNS services. A true value means the zone will not receive security or performance benefits.\nPossible values: true, false."
  default     = false
}

variable "jump_start" {
  type        = bool
  description = "Automatically attempt to fetch existing DNS records on creation. Ignored after zone is created.\nPossible values: true, false."
  default     = false
}

variable "plan" {
  type        = string
  description = "The desired plan for the zone. Can be updated once the one is created. Changing this value will create/cancel associated subscriptions.\nPossible values: \"free\", \"pro\", \"business\", \"enterprise\", \"partners_free\", \"partners_pro\", \"partners_business\", \"partners_enterprise\"."
  default     = "free"
}

variable "type" {
  type        = string
  description = "A full zone implies that DNS is hosted with Cloudflare. A partial zone is typically a partner-hosted zone or a CNAME setup.\nPossible values: \"full\", \"partial\"."
  default     = "full"
}

# cloudflare_zone_settings_override resource

variable "always_online" {
  type        = string
  description = "When enabled, Always Online will serve pages from our cache if your server is offline.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "always_use_https" {
  type        = string
  description = "Reply to all requests for URLs that use 'http' with a 301 redirect to the equivalent 'https' URL. If you only want to redirect for a subset of requests, consider creating an 'Always use HTTPS' page rule.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"

  # The provider does not validate the variable value at the `terraform plan` stage
  validation {
    condition     = contains(["off", "on"], var.always_use_https)
    error_message = "Error details: The always_use_https value must be one of the following: \"on\", \"off\"."
  }
}

variable "automatic_https_rewrites" {
  type        = string
  description = "Enable the Automatic HTTPS Rewrites feature for this zone.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "brotli" {
  type        = string
  description = "When the client requesting an asset supports the brotli compression algorithm, Cloudflare will serve a brotli compressed version of the asset.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "browser_check" {
  type        = string
  description = "Browser Integrity Check is similar to Bad Behavior and looks for common HTTP headers abused most commonly by spammers and denies access to your page. It will also challenge visitors that do not have a user agent or a non standard user agent (also commonly used by abuse bots, crawlers or visitors).\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "development_mode" {
  type        = string
  description = "Development Mode temporarily allows you to enter development mode for your websites if you need to make changes to your site. This will bypass Cloudflare's accelerated cache and slow down your site, but is useful if you are making changes to cacheable content (like images, css, or JavaScript) and would like to see those changes right away. Once entered, development mode will last for 3 hours and then automatically toggle off.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "early_hints" {
  type        = string
  description = "When enabled, Cloudflare will attempt to speed up overall page loads by serving 103 responses with Link headers from the final response (https://developers.cloudflare.com/cache/about/early-hints).\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "email_obfuscation" {
  type        = string
  description = "Encrypt email adresses on your web page from bots, while keeping them visible to humans.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "hotlink_protection" {
  type        = string
  description = "When enabled, the Hotlink Protection option ensures that other sites cannot suck up your bandwidth by building pages that use images hosted on your site. Anytime a request for an image on your site hits Cloudflare, we check to ensure that it's not another site requesting them. People will still be able to download and view images from your page, but other sites won't be able to steal them for use on their own pages.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "http2" {
  type        = string
  description = "HTTP2 setting.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "http3" {
  type        = string
  description = "HTTP3 setting.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "ip_geolocation" {
  type        = string
  description = "Enable IP Geolocation to have Cloudflare geolocate visitors to your website and pass the country code to you.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "ipv6" {
  type        = string
  description = "Enable IPv6 on all subdomains that are Cloudflare enabled.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "mirage" {
  type        = string
  description = "Automatically optimize image loading for website visitors on mobile devices.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "opportunistic_encryption" {
  type        = string
  description = "Enable the Opportunistic Encryption feature for this zone.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "opportunistic_onion" {
  type        = string
  description = "Add an Alt-Svc header to all legitimate requests from Tor, allowing the connection to use our onion services instead of exit nodes.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "orange_to_orange" {
  type        = string
  description = "Orange to Orange (O2O) allows zones on Cloudflare to CNAME to other zones also on Cloudflare.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "origin_error_page_pass_thru" {
  type        = string
  description = "Cloudflare will proxy customer error pages on any 502,504 errors on origin server instead of showing a default Cloudflare error page. This does not apply to 522 errors.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "prefetch_preload" {
  type        = string
  description = "Cloudflare will prefetch any URLs that are included in the response headers.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "privacy_pass" {
  type        = string
  description = "Privacy Pass is a browser extension developed by the Privacy Pass Team to improve the browsing experience for your visitors. Enabling Privacy Pass will reduce the number of CAPTCHAs shown to your visitors.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "response_buffering" {
  type        = string
  description = "Enables or disables buffering of responses from the proxied server. Cloudflare may buffer the whole payload to deliver it at once to the client versus allowing it to be delivered in chunks. By default, the proxied server streams directly and is not buffered by Cloudflare.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "rocket_loader" {
  type        = string
  description = "Rocket Loader is a general-purpose asynchronous JavaScript optimisation which prioritises the rendering of your content while loading your site's Javascript asynchronously. Turning on Rocket Loader will immediately improve a web page's rendering time, sometimes measured as Time to First Paint (TTFP) and also the window.onload time (assuming there is JavaScript on the page), which can have a positive impact on your Google search ranking. When turned on, Rocket Loader will automatically defer the loading of all Javascript referenced in your HTML, with no configuration required.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\", \"manual\"."
  default     = "off"
}

variable "server_side_exclude" {
  type        = string
  description = "If there is sensitive content on your website that you want visible to real visitors, but that you want to hide from suspicious visitors, all you have to do is wrap the content with Cloudflare SSE tags. Wrap any content that you want to be excluded from suspicious visitors in the following SSE tags: <!--sse--><!--/sse-->. For example: <!--sse--> Bad visitors won't see my phone number, 555-555-5555 <!--/sse-->. Note: SSE only will work with HTML. If you have HTML minification enabled, you won't see the SSE tags in your HTML source when it's served through Cloudflare. SSE will still function in this case, as Cloudflare's HTML minification and SSE functionality occur on-the-fly as the resource moves through our network to the visitor's computer.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "sort_query_string_for_cache" {
  type        = string
  description = "Cloudflare will treat files with the same query strings as the same file in cache, regardless of the order of the query strings.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "tls_client_auth" {
  type        = string
  description = "TLS Client Auth requires Cloudflare to connect to your origin server using a client certificate.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "true_client_ip_header" {
  type        = string
  description = "Allows customer to continue to use True Client IP (Akamai feature) in the headers we send to the origin.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "universal_ssl" {
  type        = string
  description = "Disabling Universal SSL removes any currently active Universal SSL certificates for your zone from the edge and prevents any future Universal SSL certificates from being ordered. If there are no dedicated certificates or custom certificates uploaded for the domain, visitors will be unable to access the domain over HTTPS.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "on"
}

variable "waf" {
  type        = string
  description = "The WAF examines HTTP requests to your website. It inspects both GET and POST requests and applies rules to help filter out illegitimate traffic from legitimate website visitors. The Cloudflare WAF inspects website addresses or URLs to detect anything out of the ordinary. If the Cloudflare WAF determines suspicious user behavior, then the WAF will 'challenge' the web visitor with a page that asks them to submit a CAPTCHA successfully to continue their action. If the challenge is failed, the action will be stopped. What this means is that Cloudflare's WAF will block any traffic identified as illegitimate before it reaches your origin web server.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "webp" {
  type        = string
  description = "When the client requesting the image supports the WebP image codec, Cloudflare will serve a WebP version of the image when WebP offers a performance advantage over the original image format. Note that the value specified will be ignored unless polish is turned on (i.e. is \"lossless\" or \"lossy\").\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "websockets" {
  type        = string
  description = "WebSockets are open connections sustained between the client and the origin server. Inside a WebSockets connection, the client and the origin can pass data back and forth without having to reestablish sessions. This makes exchanging data within a WebSockets connection fast. WebSockets are often used for real-time applications such as live chat and gaming.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "zero_rtt" {
  type        = string
  description = "0-RTT setting.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\"."
  default     = "off"
}

variable "cache_level" {
  type        = string
  description = "Cache Level functions based off the setting level. The basic setting will cache most static resources (i.e., css, images, and JavaScript). The simplified setting will ignore the query string when delivering a cached resource. The aggressive setting will cache all static resources, including ones with a query string.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"aggressive\", \"basic\", \"simplified\"."
  default     = "aggressive"
}

variable "cname_flattening" {
  type        = string
  description = "CNAME flattening setting.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"flatten_at_root\", \"flatten_all\", \"flatten_none\"."
  default     = "flatten_at_root"
}

variable "h2_prioritization" {
  type        = string
  description = "HTTP/2 Edge Prioritization optimises the delivery of resources served through HTTP/2 to improve page load performance. It also supports fine control of content delivery when used in conjunction with Workers.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\", \"custom\"."
  default     = "off"
}

variable "image_resizing" {
  type        = string
  description = "Image Resizing provides on-demand resizing, conversion and optimisation for images served through Cloudflare's network.\nAvailable on the following plans: \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\", \"open\"."
  default     = "off"
}

variable "min_tls_version" {
  type        = string
  description = "Only accept HTTPS requests that use at least the TLS protocol version specified. For example, if TLS 1.1 is selected, TLS 1.0 connections will be rejected, while 1.1, 1.2, and 1.3 (if enabled) will be permitted.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"1.0\", \"1.1\", \"1.2\", \"1.3\"."
  default     = "1.0"
}

variable "polish" {
  type        = string
  description = "Strips metadata and compresses your images for faster page load times. Basic (Lossless): Reduce the size of PNG, JPEG, and GIF files - no impact on visual quality. Basic + JPEG (Lossy): Further reduce the size of JPEG files for faster image loading. Larger JPEGs are converted to progressive images, loading a lower-resolution image first and ending in a higher-resolution version. Not recommended for hi-res photography sites.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"off\", \"lossless\", \"lossy\"."
  default     = "off"
}

variable "proxy_read_timeout" {
  type        = number
  description = "Maximum time between two read operations from origin.\nAvailable on the following plans: \"enterprise\", \"partners_enterprise\".\nPossible values: between 1 and 6000."
  default     = 100

  # The provider does not validate the variable value at the `terraform plan` stage
  validation {
    condition     = var.proxy_read_timeout >= 1 && var.proxy_read_timeout <= 6000
    error_message = "Error details: The proxy_read_timeout value must be between 1 and 6000."
  }
}

variable "pseudo_ipv4" {
  type        = string
  description = "Pseudo IPv4 setting.\nAvailable on the following plans: \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"off\", \"add_header\", \"overwrite_header\"."
  default     = "off"
}

variable "security_level" {
  type        = string
  description = "Choose the appropriate security profile for your website, which will automatically adjust each of the security settings. If you choose to customize an individual security setting, the profile will become Custom.\nAvailability of values depending on the plan:\n\"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\": \"essentially_off\", \"low\", \"medium\", \"high\", \"under_attack\";\n\"enterprise\", \"partners_enterprise\": \"off\", \"essentially_off\", \"low\", \"medium\", \"high\", \"under_attack\".\nPossible values: \"off\", \"essentially_off\", \"low\", \"medium\", \"high\", \"under_attack\"."
  default     = "medium"

  # If the variable value is not one of the allowed values, then the explicitly specified value is ignored due to how the variable value is defined in main.tf
  # Thus, the variable value validation should be used because the provider will not validate the variable value at the `terraform plan` stage
  validation {
    condition     = contains(["off", "essentially_off", "low", "medium", "high", "under_attack"], var.security_level)
    error_message = "Error details: The security_level value must be one of the following: \"off\", \"essentially_off\", \"low\", \"medium\", \"high\", \"under_attack\"."
  }
}

variable "ssl" {
  type        = string
  description = "SSL encrypts your visitor's connection and safeguards credit card numbers and other personal data to and from your website. SSL can take up to 5 minutes to fully activate. Requires Cloudflare active on your root domain or www domain. Off: no SSL between the visitor and Cloudflare, and no SSL between Cloudflare and your web server (all HTTP traffic). Flexible: SSL between the visitor and Cloudflare -- visitor sees HTTPS on your site, but no SSL between Cloudflare and your web server. You don't need to have an SSL cert on your web server, but your visitors will still see the site as being HTTPS enabled. Full: SSL between the visitor and Cloudflare -- visitor sees HTTPS on your site, and SSL between Cloudflare and your web server. You'll need to have your own SSL cert or self-signed cert at the very least. Full (Strict): SSL between the visitor and Cloudflare -- visitor sees HTTPS on your site, and SSL between Cloudflare and your web server. You'll need to have a valid SSL certificate installed on your web server. This certificate must be signed by a certificate authority, have an expiration date in the future, and respond for the request domain name (hostname).\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"off\", \"flexible\", \"full\", \"strict\", \"origin_pull\"."
  default     = "off"
}

variable "tls_1_3" {
  type        = string
  description = "Enable Crypto TLS 1.3 feature for this zone.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: \"on\", \"off\", \"zrt\"."
  default     = "off"
}

variable "browser_cache_ttl" {
  type        = number
  description = "Browser Cache TTL (in seconds) specifies how long Cloudflare-cached resources will remain on your visitors' computers. Cloudflare will honor any larger times specified by your server. Setting a TTL of 0 is equivalent to selecting `Respect Existing Headers`.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: 0, 30, 60, 300, 1200, 1800, 3600, 7200, 10800, 14400, 18000, 28800, 43200, 57600, 72000, 86400, 172800, 259200, 345600, 432000, 691200, 1382400, 2073600, 2678400, 5356800, 16070400, 31536000."
  default     = 14400
}

variable "challenge_ttl" {
  type        = number
  description = "Specify how long a visitor is allowed access to your site after successfully completing a challenge (such as a CAPTCHA). After the TTL has expired the visitor will have to complete a new challenge. We recommend a 15 - 45 minute setting and will attempt to honor any setting above 45 minutes.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: 300, 900, 1800, 2700, 3600, 7200, 10800, 14400, 28800, 57600, 86400, 604800, 2592000, 31536000."
  default     = 1800
}

variable "max_upload" {
  type        = number
  description = "The amount of data visitors can upload to your website in a single request.\nAvailability of values depending on the plan:\n\"free\", \"pro\", \"partners_pro\": 100;\n\"business\", \"partners_business\": 125, 150, 175, 200;\n\"enterprise\", \"partners_enterprise\": 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500.\nPossible values: 100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500."
  default     = 100

  # The provider does not validate the variable value at the `terraform plan` stage
  # If the variable value is not one of the allowed values, then the explicitly specified value is ignored due to how the variable value is defined in main.tf
  # Thus, the variable value validation should be used because the provider will not validate the variable value at the `terraform plan` stage
  validation {
    condition     = contains([100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500], var.max_upload)
    error_message = "Error details: The max_upload value must be one of the following: 100, 125, 150, 175, 200, 225, 250, 275, 300, 325, 350, 375, 400, 425, 450, 475, 500."
  }
}

variable "ciphers" {
  type        = list(string)
  description = "An allowlist of ciphers for TLS termination. These ciphers must be in the BoringSSL format.\nAvailable on the following plans: Advanced Certificate Manager plan.\nPossible values for each element in the list: \"ECDHE-ECDSA-AES128-GCM-SHA256\", \"ECDHE-ECDSA-CHACHA20-POLY1305\", \"ECDHE-RSA-AES128-GCM-SHA256\", \"ECDHE-RSA-CHACHA20-POLY1305\", \"ECDHE-ECDSA-AES128-SHA256\", \"ECDHE-ECDSA-AES128-SHA\", \"ECDHE-RSA-AES128-SHA256\", \"ECDHE-RSA-AES128-SHA\", \"AES128-GCM-SHA256\", \"AES128-SHA256\", \"AES128-SHA\", \"ECDHE-ECDSA-AES256-GCM-SHA384\", \"ECDHE-ECDSA-AES256-SHA384\", \"ECDHE-RSA-AES256-GCM-SHA384\", \"ECDHE-RSA-AES256-SHA384\", \"ECDHE-RSA-AES256-SHA\", \"AES256-GCM-SHA384\", \"AES256-SHA256\", \"AES256-SHA\", \"DES-CBC3-SHA\", \"AEAD-AES128-GCM-SHA256\", \"AEAD-AES256-GCM-SHA384\", \"AEAD-CHACHA20-POLY1305-SHA256\"."
  default     = []

  # The provider does not validate the variable value at the `terraform plan` stage
  # Supported cipher suites by protocol can be found at https://developers.cloudflare.com/ssl/ssl-tls/cipher-suites/#supported-cipher-suites-by-protocol
  # When trying to use the ciphers "AEAD-AES128-GCM-SHA256", "AEAD-AES256-GCM-SHA384", "AEAD-CHACHA20-POLY1305-SHA256", error 1007 is returned from the API, despite the fact that the ciphers are declared to be supported
  validation {
    condition     = alltrue([for i in var.ciphers : contains(["ECDHE-ECDSA-AES128-GCM-SHA256", "ECDHE-ECDSA-CHACHA20-POLY1305", "ECDHE-RSA-AES128-GCM-SHA256", "ECDHE-RSA-CHACHA20-POLY1305", "ECDHE-ECDSA-AES128-SHA256", "ECDHE-ECDSA-AES128-SHA", "ECDHE-RSA-AES128-SHA256", "ECDHE-RSA-AES128-SHA", "AES128-GCM-SHA256", "AES128-SHA256", "AES128-SHA", "ECDHE-ECDSA-AES256-GCM-SHA384", "ECDHE-ECDSA-AES256-SHA384", "ECDHE-RSA-AES256-GCM-SHA384", "ECDHE-RSA-AES256-SHA384", "ECDHE-RSA-AES256-SHA", "AES256-GCM-SHA384", "AES256-SHA256", "AES256-SHA", "DES-CBC3-SHA", "AEAD-AES128-GCM-SHA256", "AEAD-AES256-GCM-SHA384", "AEAD-CHACHA20-POLY1305-SHA256"], i)])
    error_message = "Error details: The ciphers value must be a list of one or more of the following values: \"ECDHE-ECDSA-AES128-GCM-SHA256\", \"ECDHE-ECDSA-CHACHA20-POLY1305\", \"ECDHE-RSA-AES128-GCM-SHA256\", \"ECDHE-RSA-CHACHA20-POLY1305\", \"ECDHE-ECDSA-AES128-SHA256\", \"ECDHE-ECDSA-AES128-SHA\", \"ECDHE-RSA-AES128-SHA256\", \"ECDHE-RSA-AES128-SHA\", \"AES128-GCM-SHA256\", \"AES128-SHA256\", \"AES128-SHA\", \"ECDHE-ECDSA-AES256-GCM-SHA384\", \"ECDHE-ECDSA-AES256-SHA384\", \"ECDHE-RSA-AES256-GCM-SHA384\", \"ECDHE-RSA-AES256-SHA384\", \"ECDHE-RSA-AES256-SHA\", \"AES256-GCM-SHA384\", \"AES256-SHA256\", \"AES256-SHA\", \"DES-CBC3-SHA\", \"AEAD-AES128-GCM-SHA256\", \"AEAD-AES256-GCM-SHA384\", \"AEAD-CHACHA20-POLY1305-SHA256\"."
  }
}

variable "minify" {
  type = object({
    css  = optional(string)
    html = optional(string)
    js   = optional(string)
  })
  description = "Automatically minify certain assets for your website.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values for each argument: \"on\", \"off\"."
  # These defaults don't really apply and are just for documentation purposes, see `main.tf` file
  default = {
    css  = "off"
    html = "off"
    js   = "off"
  }
}

variable "mobile_redirect" {
  type = object({
    mobile_subdomain = string
    status           = optional(string)
    strip_uri        = optional(bool)
  })
  description = "Automatically redirect visitors on mobile devices to a mobile-optimized subdomain.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values for the `status` argument: \"on\", \"off\".\nPossible values for the `strip_uri` argument: true, false."
  # These defaults don't really apply and are just for documentation purposes, see `main.tf` file
  default = {
    mobile_subdomain = ""
    status           = "off"
    strip_uri        = false
  }

  # The provider does not check if the `mobile_subdomain` value is specified when the `status` value is `on` at the `terraform plan` stage
  validation {
    condition     = try((length(var.mobile_redirect.mobile_subdomain) >= 1 || var.mobile_redirect.mobile_subdomain == "" && var.mobile_redirect.status == "off"), true)
    error_message = "Error details: The mobile_subdomain value must have a minimum length of 1."
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
  description = "Cloudflare security headers for a zone.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values for the `enabled` argument: true, false.\nPossible values for the `preload` argument: true, false.\nPossible values for the `max_age` argument: between 0 and 2147483647.\nPossible values for the `include_subdomains` argument: true, false.\nPossible values for the `nosniff` argument: true, false."
  # These defaults don't really apply and are just for documentation purposes, see `main.tf` file
  default = {
    enabled            = true
    preload            = false
    max_age            = 86400
    include_subdomains = true
    nosniff            = true
  }

  # The provider does not validate the `max_age` value at the `terraform plan` stage
  # The maximum value for the `max_age` field is a signed integer
  validation {
    condition     = var.security_header.max_age >= 0 && var.security_header.max_age <= 2147483647
    error_message = "Error details: The max_age value must be between 0 and 2147483647."
  }
}

# cloudflare_zone_dnssec resource

variable "enable_dnssec" {
  type        = bool
  description = "Enable or disable DNSSEC.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values: true, false."
  default     = false
}

# cloudflare_record resource

variable "records" {
  type = list(object({
    record_name = string
    type        = string
    name        = optional(string)
    value       = optional(string)
    data = optional(object({
      algorithm      = optional(number)
      altitude       = optional(number)
      certificate    = optional(string)
      content        = optional(string)
      digest         = optional(string)
      digest_type    = optional(number)
      fingerprint    = optional(string)
      flags          = optional(string)
      key_tag        = optional(number)
      lat_degrees    = optional(number)
      lat_direction  = optional(string)
      lat_minutes    = optional(number)
      lat_seconds    = optional(number)
      long_degrees   = optional(number)
      long_direction = optional(string)
      long_minutes   = optional(number)
      long_seconds   = optional(number)
      matching_type  = optional(number)
      name           = optional(string)
      order          = optional(number)
      port           = optional(number)
      precision_horz = optional(number)
      precision_vert = optional(number)
      preference     = optional(number)
      priority       = optional(number)
      proto          = optional(string)
      protocol       = optional(number)
      public_key     = optional(string)
      regex          = optional(string)
      replacement    = optional(string)
      selector       = optional(number)
      service        = optional(string)
      size           = optional(number)
      tag            = optional(string)
      target         = optional(string)
      type           = optional(number)
      usage          = optional(number)
      value          = optional(string)
      weight         = optional(number)
    }))
    priority = optional(number)
    ttl      = optional(number)
    proxied  = optional(bool)
  }))
  description = "Zone's DNS records.\nAvailable on the following plans: \"free\", \"pro\", \"partners_pro\", \"business\", \"partners_business\", \"enterprise\", \"partners_enterprise\".\nPossible values for the `type` argument: \"A\", \"AAAA\", \"CAA\", \"CERT\", \"CNAME\", \"DNSKEY\", \"DS\", \"HTTPS\", \"LOC\", \"MX\", \"NAPTR\", \"NS\", \"PTR\", \"SMIMEA\", \"SPF\", \"SRV\", \"SSHFP\", \"SVCB\", \"TLSA\", \"TXT\", \"URI\".\nPossible values for the `priority` argument: between 0 and 65535.\nPossible values for the `ttl` argument: between 60 and 86400, or 1 for automatic."
  default     = []

  # The provider does not check if either `value` or `data` is provided at the `terraform plan` stage
  validation {
    condition     = alltrue([for i in var.records : try(i.value != null || i.data != null)])
    error_message = "Error details: Either the value or the data must be provided for each record."
  }

  # The provider does not check if `priority` are provided for "MX" type records at the `terraform plan` stage
  validation {
    condition     = alltrue([for i in var.records : try(i.type == "MX" ? i.priority != null : true)])
    error_message = "Error details: The priority must not be null for each record of type \"MX\"."
  }

  # Actually, `priority` values validation is not required, it accepts any values, including negative ones, but for values outside the range from 0 to 65535, the resulting value may be unexpected for the end user
  validation {
    condition     = alltrue([for i in var.records : try(i.priority >= 0 && i.priority <= 65535, true)])
    error_message = "Error details: The priority values must be between 0 and 65535."
  }

  # The provider does not validate the `ttl` values at the `terraform plan` stage
  validation {
    condition     = alltrue([for i in var.records : try(i.ttl == 1 || i.ttl >= 60 && i.ttl <= 86400, true)])
    error_message = "Error details: The ttl values must be between 60 and 86400, or 1 for automatic."
  }
}

# cloudflare_page_rule resource

# The number of rules is not checked against the maximum available number of rules on the current plan, since the rules can be purchased in addition, and there is no data source for obtaining the available number of rules
variable "page_rules" {
  type = list(object({
    page_rule_name = string
    target         = string
    actions = object({
      always_online            = optional(string)
      always_use_https         = optional(bool)
      automatic_https_rewrites = optional(string)
      browser_cache_ttl        = optional(number)
      browser_check            = optional(string)
      bypass_cache_on_cookie   = optional(string)
      cache_by_device_type     = optional(string)
      cache_deception_armor    = optional(string)
      cache_key_fields = optional(object({
        cookie = optional(object({
          check_presence = optional(list(string))
          include        = optional(list(string))
        }))
        header = optional(object({
          check_presence = optional(list(string))
          exclude        = optional(list(string))
          include        = optional(list(string))
        }))
        host = optional(object({
          resolved = optional(bool)
        }))
        query_string = optional(object({
          exclude = optional(list(string))
          include = optional(list(string))
          ignore  = optional(bool)
        }))
        user = optional(object({
          device_type = optional(bool)
          geo         = optional(bool)
          lang        = optional(bool)
        }))
      }))
      cache_level     = optional(string)
      cache_on_cookie = optional(string)
      cache_ttl_by_status = optional(list(object({
        codes = string
        ttl   = number
      })))
      disable_apps           = optional(bool)
      disable_performance    = optional(bool)
      disable_railgun        = optional(bool)
      disable_security       = optional(bool)
      disable_zaraz          = optional(bool)
      edge_cache_ttl         = optional(number)
      email_obfuscation      = optional(string)
      explicit_cache_control = optional(string)
      forwarding_url = optional(object({
        url         = string
        status_code = number
      }))
      host_header_override = optional(string)
      ip_geolocation       = optional(string)
      minify = optional(object({
        html = optional(string)
        css  = optional(string)
        js   = optional(string)
      }))
      mirage                      = optional(string)
      opportunistic_encryption    = optional(string)
      origin_error_page_pass_thru = optional(string)
      polish                      = optional(string)
      resolve_override            = optional(string)
      respect_strong_etag         = optional(string)
      response_buffering          = optional(string)
      rocket_loader               = optional(string)
      security_level              = optional(string)
      server_side_exclude         = optional(string)
      smart_errors                = optional(string)
      sort_query_string_for_cache = optional(string)
      ssl                         = optional(string)
      true_client_ip_header       = optional(string)
      waf                         = optional(string)
    })
    priority = optional(number)
    status   = optional(string)
  }))
  description = "Zone's page rules.\nNumber of allowed page rules depending on the plan:\n\"free\": 3;\n\"pro\", \"partners_pro\": 20;\n\"business\", \"partners_business\": 50;\n\"enterprise\", \"partners_enterprise\": 125.\nAvailability of values depending on the plan is the same as the availability of the same settings for the cloudflare_zone_settings_override resource, and for other settings, the availability can be found at https://support.cloudflare.com/hc/en-us/articles/218411427#h_18YTlvNlZET4Poljeih3TJ."
  default     = []

  validation {
    condition     = alltrue([for page_rule in var.page_rules : anytrue([for action in page_rule.actions : try(action != null)])])
    error_message = "Error details: The action object of each rule must contain at least one non-null action."
  }

  # The provider does not validate the `browser_cache_ttl` values at the `terraform plan` stage
  # Explicitly specified value may be ignored due to how the `browser_cache_ttl` value is defined in main.tf
  # Thus, the `browser_cache_ttl` value validation should be used because the provider will not always validate the `browser_cache_ttl` value at the `terraform plan` stage
  # The `browser_cache_ttl` argument of the `cloudflare_zone_settings_override` resource only accepts values from a specific list, but any value within the allowed range can be used here
  validation {
    condition     = alltrue(flatten([for page_rule in var.page_rules : [for ttl in page_rule.actions[*].browser_cache_ttl : try(ttl >= 0 && ttl <= 31536000, true)]]))
    error_message = "Error details: The browser_cache_ttl values must be between 0 and 31536000."
  }

  # The provider does not validate the `edge_cache_ttl` values at the `terraform plan` stage
  # Explicitly specified value may be ignored due to how the `edge_cache_ttl` value is defined in main.tf
  # Thus, the `edge_cache_ttl` value validation should be used because the provider will not always validate the `edge_cache_ttl` value at the `terraform plan` stage
  validation {
    condition     = alltrue(flatten([for page_rule in var.page_rules : [for ttl in page_rule.actions[*].edge_cache_ttl : try(ttl >= 1 && ttl <= 2678400, true)]]))
    error_message = "Error details: The edge_cache_ttl values must be between 1 and 2678400."
  }

  # The provider does not check if the `forwarding_url` is set with any other actions at the `terraform plan` stage
  validation {
    condition     = alltrue([for page_rule in var.page_rules : (contains([for key, value in page_rule.actions : key if value != null && try(length(value) != 0, true)], "forwarding_url") ? length([for key, value in page_rule.actions : key if value != null && try(length(value) != 0, true)]) == 1 : true)])
    error_message = "Error details: The forwarding_url cannot be set with any other actions."
  }

  # If the `security_level` value is not one of the allowed values, then the explicitly specified value is ignored due to how the `security_level` value is defined in main.tf
  # Thus, the `security_level` value validation should be used because the provider will not validate the `security_level` value at the `terraform plan` stage
  validation {
    condition     = alltrue(flatten([for page_rule in var.page_rules : [for ttl in page_rule.actions[*].security_level : try(contains(["off", "essentially_off", "low", "medium", "high", "under_attack"], ttl), true)]]))
    error_message = "Error details: The security_level values must be one of the following: \"off\", \"essentially_off\", \"low\", \"medium\", \"high\", \"under_attack\"."
  }

  # The provider does not validate the `priority` values at the `terraform plan` stage
  # The range of values is set empirically and looks unexpected, apparently, the maximum possible number of rules is 125
  validation {
    condition     = alltrue([for page_rule in var.page_rules : try(page_rule.priority >= 0 && page_rule.priority <= 1000, true)])
    error_message = "Error details: The priority values must be between 0 and 1000."
  }
}
