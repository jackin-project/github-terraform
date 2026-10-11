# SPDX-FileCopyrightText: 2026 Alexey Zhokhov
# SPDX-License-Identifier: Apache-2.0

provider "github" {
  owner = var.github_organization
  token = var.github_token != null ? var.github_token : null
}
