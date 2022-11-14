# cloudflare_zone resource

output "zone_id" {
  value       = cloudflare_zone.this.id
  description = "The zone ID."
}

output "meta" {
  value       = cloudflare_zone.this.meta
  description = "Map of booleans, indicating some zone statuses or flags."
}

output "name_servers" {
  value       = cloudflare_zone.this.name_servers
  description = "Cloudflare-assigned name servers. This is only populated for zones that use Cloudflare DNS."
}

output "status" {
  value       = cloudflare_zone.this.status
  description = "Status of the zone. Valid values: active, pending, initializing, moved, deleted, deactivated."
}

output "vanity_name_servers" {
  value       = cloudflare_zone.this.vanity_name_servers
  description = "List of Vanity Nameservers (if set)."
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
  value       = try(cloudflare_zone_dnssec.this[0].status, null)
  description = "The status of the Zone DNSSEC."
}

output "flags" {
  value       = try(cloudflare_zone_dnssec.this[0].flags, null)
  description = "Zone DNSSEC flags."
}

output "algorithm" {
  value       = try(cloudflare_zone_dnssec.this[0].algorithm, null)
  description = "Zone DNSSEC algorithm."
}

output "key_type" {
  value       = try(cloudflare_zone_dnssec.this[0].key_type, null)
  description = "Key type used for Zone DNSSEC."
}

output "digest_type" {
  value       = try(cloudflare_zone_dnssec.this[0].digest_type, null)
  description = "Digest Type for Zone DNSSEC."
}

output "digest_algorithm" {
  value       = try(cloudflare_zone_dnssec.this[0].digest_algorithm, null)
  description = "Digest algorithm use for Zone DNSSEC."
}

output "digest" {
  value       = try(cloudflare_zone_dnssec.this[0].digest, null)
  description = "Zone DNSSEC digest."
}

output "ds" {
  value       = try(cloudflare_zone_dnssec.this[0].ds, null)
  description = "DS for the Zone DNSSEC."
}

output "key_tag" {
  value       = try(cloudflare_zone_dnssec.this[0].key_tag, null)
  description = "Key Tag for the Zone DNSSEC."
}

output "public_key" {
  value       = try(cloudflare_zone_dnssec.this[0].public_key, null)
  description = "Public Key for the Zone DNSSEC."
}

output "modified_on" {
  value       = try(cloudflare_zone_dnssec.this[0].modified_on, null)
  description = "Zone DNSSEC updated time."
}

# cloudflare_record resource

output "record_ids" {
  value       = { for k, v in cloudflare_record.this : k => v.id }
  description = "The record IDs."
}

output "record_hostnames" {
  value       = { for k, v in cloudflare_record.this : k => v.hostname }
  description = "The FQDN of the records."
}

output "record_proxiable" {
  value       = { for k, v in cloudflare_record.this : k => v.proxiable }
  description = "Shows whether these records can be proxied, must be true if setting proxied=true."
}

output "record_created_on" {
  value       = { for k, v in cloudflare_record.this : k => v.created_on }
  description = "The RFC3339 timestamp of when the records were created."
}

output "record_modified_on" {
  value       = { for k, v in cloudflare_record.this : k => v.modified_on }
  description = "The RFC3339 timestamp of when the records were last modified."
}

output "record_metadata" {
  value       = { for k, v in cloudflare_record.this : k => v.metadata }
  description = "A key-value map of string metadata Cloudflare associates with the records."
}

# cloudflare_page_rule resource

output "page_rule_ids" {
  value       = { for k, v in cloudflare_page_rule.this : k => v.id }
  description = "The page rule IDs."
}

output "page_rule_targets" {
  value       = { for k, v in cloudflare_page_rule.this : k => v.target }
  description = "The URL pattern targeted by the page rules."
}

output "page_rule_actions" {
  value       = { for k, v in cloudflare_page_rule.this : k => v.actions }
  description = "The actions applied by the page rules."
}

output "page_rule_priorities" {
  value       = { for k, v in cloudflare_page_rule.this : k => v.priority }
  description = "The priority of the page rules."
}

output "page_rule_statuses" {
  value       = { for k, v in cloudflare_page_rule.this : k => v.status }
  description = "Whether the page rules are active or disabled."
}
