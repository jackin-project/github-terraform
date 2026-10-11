# SPDX-FileCopyrightText: 2026 Alexey Zhokhov
# SPDX-License-Identifier: Apache-2.0

output "organization" {
  value = var.github_organization
}

output "managed_repositories" {
  description = "Set of managed repository names (inventory keys)"
  value       = module.repository_policy.managed_repositories
}

output "repository_settings" {
  description = "Map of repository merge and lifecycle settings"
  value       = module.repository_policy.repository_settings
}

output "required_check_contexts" {
  description = "Map of repository name to its required status-check contexts"
  value       = module.repository_policy.required_check_contexts
}

output "repository_ids" {
  description = "Map of repository name to repository ID"
  value       = module.repository_policy.repository_ids
}
