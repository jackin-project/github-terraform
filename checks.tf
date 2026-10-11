# SPDX-FileCopyrightText: 2026 Alexey Zhokhov
# SPDX-License-Identifier: Apache-2.0

# Deterministic invariant assertions to prevent policy weakening and inventory omissions

check "mandatory_target_repositories_present" {
  assert {
    condition     = toset(keys(var.repository_policies)) == toset(["homebrew-tap", "jackin", "jackin-agent-smith", "jackin-dev", "jackin-github-terraform", "jackin-marketplace", "jackin-role-action", "jackin-sentinel", "jackin-the-architect"])
    error_message = "repository_policies must contain exactly the 9 managed jackin-project repositories (8 standard plus jackin-marketplace)."
  }
}

check "all_managed_repositories_have_checks_or_reason" {
  assert {
    condition = alltrue([
      for name, policy in var.repository_policies :
      (
        length(policy.required_checks) > 0
        && alltrue([for c in policy.required_checks : trimspace(c) != ""])
        && policy.no_ci_reason == null
        ) || (
        length(policy.required_checks) == 0
        && policy.no_ci_reason != null
        && trimspace(policy.no_ci_reason) != ""
      )
    ])
    error_message = "Each entry must satisfy: non-empty blank-free required_checks with null no_ci_reason, XOR empty checks with non-empty no_ci_reason."
  }
}

check "no_ci_exception_allowlist_is_explicit" {
  assert {
    condition     = length([for name, policy in var.repository_policies : name if policy.no_ci_reason != null]) == 0
    error_message = "No jackin-project repository carries a no_ci_reason exception; every entry must declare required checks."
  }
}

check "self_protection_enforced" {
  assert {
    condition     = contains(keys(var.repository_policies), "jackin-github-terraform")
    error_message = "jackin-github-terraform must remain in the managed repository inventory; every inventory entry receives both rulesets."
  }
}

check "jackin_terraform_required_checks_match_ci" {
  assert {
    condition = contains(keys(var.repository_policies), "jackin-github-terraform") ? (
      length(var.repository_policies["jackin-github-terraform"].required_checks) == 2 &&
      contains(var.repository_policies["jackin-github-terraform"].required_checks, "Required") &&
      contains(var.repository_policies["jackin-github-terraform"].required_checks, "DCO")
    ) : false
    error_message = "jackin-github-terraform must require the current green CI aggregator (Required) and DCO checks."
  }
}

check "update_branch_suggestions_disabled" {
  assert {
    condition = alltrue([
      for name, repo in module.repository_policy.repository_settings :
      repo.allow_update_branch == false
    ])
    error_message = "All managed repositories must disable GitHub update-branch suggestions."
  }
}

check "delete_branch_on_merge_mandate" {
  assert {
    condition = alltrue([
      for name, repo in module.repository_policy.repository_settings :
      repo.delete_branch_on_merge == true
    ])
    error_message = "All managed repositories must enforce delete_branch_on_merge = true."
  }
}

check "squash_only_merge_mandate" {
  assert {
    condition = alltrue([
      for name, repo in module.repository_policy.repository_settings :
      repo.allow_squash_merge == true &&
      repo.allow_merge_commit == false &&
      repo.allow_rebase_merge == false &&
      repo.squash_merge_commit_title == "PR_TITLE" &&
      repo.squash_merge_commit_message == "PR_BODY"
    ])
    error_message = "All managed repositories must enforce squash-only merge policy with PR_TITLE/PR_BODY."
  }
}

check "thread_resolution_and_active_enforcement" {
  assert {
    condition = alltrue([
      for name, gate in module.repository_policy.ruleset_enforcement :
      gate.enforcement == "active" &&
      gate.tags_enforcement == "active" &&
      gate.required_review_thread_resolution == true
    ])
    error_message = "All protect-main/protect-tags rulesets must enforce active with required review-thread resolution."
  }
}

check "zero_bypass_actors" {
  assert {
    condition = alltrue([
      for name, gate in module.repository_policy.ruleset_enforcement :
      length(gate.bypass_actors) == 0
    ])
    error_message = "No repository may declare bypass actors on its protect-main ruleset."
  }
}
