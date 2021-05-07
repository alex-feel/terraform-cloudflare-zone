# cloudflare_zone resource

output "zone_id" {
  value       = cloudflare_zone.this.id
  description = "The zone ID."
}

output "plan" {
  value       = cloudflare_zone.this.plan
  description = "The name of the commercial plan to apply to the zone."
}

output "vanity_name_servers" {
  value       = cloudflare_zone.this.vanity_name_servers
  description = "List of Vanity Nameservers (if set)."
}

output "meta_wildcard_proxiable" {
  value       = cloudflare_zone.this.meta.wildcard_proxiable
  description = "Indicates whether wildcard DNS records can receive Cloudflare security and performance features."
}

output "meta_phishing_detected" {
  value       = cloudflare_zone.this.meta.phishing_detected
  description = "Indicates if URLs on the zone have been identified as hosting phishing content."
}

output "status" {
  value       = cloudflare_zone.this.status
  description = "Status of the zone. Valid values: active, pending, initializing, moved, deleted, deactivated."
}

output "name_servers" {
  value       = cloudflare_zone.this.name_servers
  description = "Cloudflare-assigned name servers. This is only populated for zones that use Cloudflare DNS."
}

output "verification_key" {
  value       = cloudflare_zone.this.verification_key
  description = "Contains the TXT record value to validate domain ownership. This is only populated for zones of type partial."
}

# cloudflare_zone_settings_override resource

output "initial_settings" {
  value       = cloudflare_zone_settings_override.this.initial_settings
  description = "Settings present in the zone at the time the resource is created. This will be used to restore the original settings when this resource is destroyed. Shares the same schema as the settings attribute (Above)."
}

output "initial_settings_read_at" {
  value       = cloudflare_zone_settings_override.this.initial_settings_read_at
  description = "Time when this resource was created and the initial_settings were set."
}

output "readonly_settings" {
  value       = cloudflare_zone_settings_override.this.readonly_settings
  description = "Which of the current settings are not able to be set by the user. Which settings these are is determined by plan level and user permissions."
}

output "zone_type" {
  value       = cloudflare_zone_settings_override.this.zone_type
  description = "A full zone implies that DNS is hosted with Cloudflare. A partial zone is typically a partner-hosted zone or a CNAME setup."
}

# cloudflare_zone_dnssec resource

output "dnssec_status" {
  value       = join("", cloudflare_zone_dnssec.this[*].status)
  description = "The status of the Zone DNSSEC."
}

output "flags" {
  value       = join("", cloudflare_zone_dnssec.this[*].flags)
  description = "Zone DNSSEC flags."
}

output "algorithm" {
  value       = join("", cloudflare_zone_dnssec.this[*].algorithm)
  description = "Zone DNSSEC algorithm."
}

output "key_type" {
  value       = join("", cloudflare_zone_dnssec.this[*].key_type)
  description = "Key type used for Zone DNSSEC."
}

output "digest_type" {
  value       = join("", cloudflare_zone_dnssec.this[*].digest_type)
  description = "Digest Type for Zone DNSSEC."
}

output "digest_algorithm" {
  value       = join("", cloudflare_zone_dnssec.this[*].digest_algorithm)
  description = "Digest algorithm use for Zone DNSSEC."
}

output "digest" {
  value       = join("", cloudflare_zone_dnssec.this[*].digest)
  description = "Zone DNSSEC digest."
}

output "ds" {
  value       = join("", cloudflare_zone_dnssec.this[*].ds)
  description = "DS for the Zone DNSSEC."
}

output "key_tag" {
  value       = join("", cloudflare_zone_dnssec.this[*].key_tag)
  description = "Key Tag for the Zone DNSSEC."
}

output "public_key" {
  value       = join("", cloudflare_zone_dnssec.this[*].public_key)
  description = "Public Key for the Zone DNSSEC."
}

output "modified_on" {
  value       = join("", cloudflare_zone_dnssec.this[*].modified_on)
  description = "Zone DNSSEC updated time."
}

# cloudflare_record resource

output "record_ids" {
  value       = { for k, v in cloudflare_record.this : k => v.id }
  description = "The record ID."
}

output "record_hostnames" {
  value       = { for k, v in cloudflare_record.this : k => v.hostname }
  description = "The FQDN of the record."
}

output "record_proxiable" {
  value       = { for k, v in cloudflare_record.this : k => v.proxiable }
  description = "Shows whether this record can be proxied, must be true if setting proxied=true."
}

output "record_created_on" {
  value       = { for k, v in cloudflare_record.this : k => v.created_on }
  description = "The RFC3339 timestamp of when the record was created."
}

output "record_modified_on" {
  value       = { for k, v in cloudflare_record.this : k => v.modified_on }
  description = "The RFC3339 timestamp of when the record was last modified."
}

output "record_metadata" {
  value       = { for k, v in cloudflare_record.this : k => v.metadata }
  description = "A key-value map of string metadata Cloudflare associates with the record."
}
