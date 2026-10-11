# jackin-github-terraform

Manages GitHub repository settings and branch/tag protection for the
`jackin-project` organization: 9 repositories, each with repository merge
settings plus `protect-main` and `protect-tags` rulesets.

## Layout

- `variables.tf` — `repository_policies` inventory (single source of truth).
- `locals.tf` — `check_templates` copy-paste source for check lists.
- `repositories.tf` — `module.repository_policy` wiring.
- `modules/repository-policy/` — shared policy module (identical across orgs).
- `checks.tf` — invariant guards (no scripts).
- `imports.tf` — bootstrap import triples (one per repo: settings + 2 rulesets).
- `providers.tf`, `versions.tf`, `outputs.tf` — provider, pins, outputs.

## Adding a repository

1. Add one entry to `repository_policies` in `variables.tf`, copying a check
   list from `locals.tf` (`standard` = `["Required", "DCO"]`,
   `policy` = `["Policy"]`); bespoke checks inline with a comment citing the
   producing workflow. Repos with no CI use `required_checks = []` plus a
   non-empty `no_ci_reason` and extend the allowlist check in `checks.tf`.
2. Add one import triple (settings + `protect_main` + `protect_tags`) to
   `imports.tf` using the live numeric ruleset IDs.

## Verification

```sh
tofu fmt -check -recursive
tofu init -backend=false -input=false -lockfile=readonly
tofu validate -no-color
```
