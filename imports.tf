# SPDX-FileCopyrightText: 2026 Alexey Zhokhov
# SPDX-License-Identifier: Apache-2.0

# Adopt the existing GitHub resources into the default local state before managing them.
# These stable IDs prevent a fresh state from planning duplicate repositories or rulesets.

import {
  to = github_organization_settings.jackin_project
  id = "273541039"
}

import {
  to = github_actions_organization_permissions.jackin_project
  id = "jackin-project"
}

import {
  to = github_actions_organization_workflow_permissions.jackin_project
  id = "jackin-project"
}

import {
  to = module.repository_policy.github_repository.managed_settings["homebrew-tap"]
  id = "homebrew-tap"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["homebrew-tap"]
  id = "homebrew-tap:15170998"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["homebrew-tap"]
  id = "homebrew-tap:15179223"
}

import {
  to = module.repository_policy.github_repository.managed_settings["jackin"]
  id = "jackin"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["jackin"]
  id = "jackin:14746904"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["jackin"]
  id = "jackin:15179226"
}

import {
  to = module.repository_policy.github_repository.managed_settings["jackin-agent-smith"]
  id = "jackin-agent-smith"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["jackin-agent-smith"]
  id = "jackin-agent-smith:14742580"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["jackin-agent-smith"]
  id = "jackin-agent-smith:15179228"
}

import {
  to = module.repository_policy.github_repository.managed_settings["jackin-dev"]
  id = "jackin-dev"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["jackin-dev"]
  id = "jackin-dev:14742570"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["jackin-dev"]
  id = "jackin-dev:15179232"
}

import {
  to = module.repository_policy.github_repository.managed_settings["github-terraform"]
  id = "github-terraform"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["github-terraform"]
  id = "github-terraform:15175310"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["github-terraform"]
  id = "github-terraform:15179227"
}

import {
  to = module.repository_policy.github_repository.managed_settings["jackin-marketplace"]
  id = "jackin-marketplace"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["jackin-marketplace"]
  id = "jackin-marketplace:14742574"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["jackin-marketplace"]
  id = "jackin-marketplace:15179224"
}

import {
  to = module.repository_policy.github_repository.managed_settings["jackin-role-action"]
  id = "jackin-role-action"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["jackin-role-action"]
  id = "jackin-role-action:15170996"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["jackin-role-action"]
  id = "jackin-role-action:16515394"
}

import {
  to = module.repository_policy.github_repository.managed_settings["jackin-sentinel"]
  id = "jackin-sentinel"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["jackin-sentinel"]
  id = "jackin-sentinel:17461058"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["jackin-sentinel"]
  id = "jackin-sentinel:17461059"
}

import {
  to = module.repository_policy.github_repository.managed_settings["jackin-the-architect"]
  id = "jackin-the-architect"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_main["jackin-the-architect"]
  id = "jackin-the-architect:14742576"
}

import {
  to = module.repository_policy.github_repository_ruleset.protect_tags["jackin-the-architect"]
  id = "jackin-the-architect:15179230"
}
