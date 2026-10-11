# SPDX-FileCopyrightText: 2026 Alexey Zhokhov
# SPDX-License-Identifier: Apache-2.0

# Canonical check-list templates. Terraform requires variable defaults to be
# literals, so inventory entries in variables.tf repeat these lists verbatim;
# keep both in sync. Templates are the documented copy-paste source for adding
# a repo (see README.md).
locals {
  check_templates = {
    standard = ["Required", "DCO"]
    policy   = ["Policy"]
  }
}
