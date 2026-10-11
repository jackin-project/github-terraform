# github-terraform

Manages GitHub repository settings and branch/tag protection for the
`jackin-project` organization: 9 repositories, each with repository merge
settings plus `protect-main` and `protect-tags` rulesets.

## Layout

- `variables.tf` — `repository_policies` inventory (single source of truth).
- `locals.tf` — `check_templates` copy-paste source for check lists.
- `repositories.tf` — `module.repository_policy` wiring.
- `organization.tf` — organization settings and Actions/workflow permissions.
- `modules/repository-policy/` — shared policy module (identical across orgs).
- `checks.tf` — invariant guards (no scripts).
- `imports.tf` — bootstrap import triples (one per repo: settings + 2 rulesets).
- `providers.tf`, `versions.tf`, `outputs.tf` — provider, pins, outputs.

## Authentication

Run tofu with `GITHUB_TOKEN` exported in the shell, or via the mise tasks
`mise run tofu:plan` / `mise run tofu:apply`, which inject the organization
token from 1Password. The token needs Administration: write on every managed
repository. It also needs org admin on `jackin-project` for the organization
settings and Actions policies in `organization.tf`.

## Adding a repository

1. Add one entry to `repository_policies` in `variables.tf`, copying a check
   list from `locals.tf` (`standard` = `["Required", "DCO"]`, `policy` =
   `["Policy"]`); bespoke checks inline with a comment citing the producing
   workflow. Repos with no CI use `required_checks = []` plus a non-empty
   `no_ci_reason`, extend the allowlist check in `checks.tf`, and add the
   name to the mandatory list in `mandatory_target_repositories_present` in
   `checks.tf` (updating its count and message).
2. Add one import triple (settings + `protect_main` + `protect_tags`) to
   `imports.tf` using the live numeric ruleset IDs.

## Organization overlays

- `organization.tf` manages the org profile (`github_organization_settings`),
  Actions availability/allow policy (`github_actions_organization_permissions`),
  and default `GITHUB_TOKEN` workflow permissions
  (`github_actions_organization_workflow_permissions`).

## Verification

```sh
tofu fmt -check -recursive
tofu init -backend=false -input=false -lockfile=readonly
tofu validate -no-color
```

OpenTofu is pinned via `mise.toml` (opentofu 1.13.1); existing repos are
imported via `imports.tf` on first apply.
