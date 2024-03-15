resource "github_repository" "this" {
  name       = var.name
  visibility = var.is_public ? "public" : "private"

  allow_auto_merge    = false
  allow_update_branch = true
  allow_merge_commit  = false
  allow_rebase_merge  = false
  allow_squash_merge  = true

  delete_branch_on_merge = true

  has_downloads = true
  has_issues    = true
  has_projects  = true

  vulnerability_alerts = true

  squash_merge_commit_title = "PR_TITLE"
}

resource "github_branch_default" "this" {
  branch     = var.master_branch_name
  repository = github_repository.this.name
}

resource "github_branch_protection" "this" {
  count = var.master_branch_protection ? 1 : 0

  repository_id = github_repository.this.node_id
  pattern       = var.master_branch_name

  lock_branch                     = true
  require_conversation_resolution = true
  required_linear_history         = true
  enforce_admins                  = false
  allows_deletions                = false

  dynamic "required_status_checks" {
    for_each = length(var.master_branch_protection_status_checks) > 0 ? [1] : []
    content {
      strict   = true
      contexts = var.master_branch_protection_status_checks
    }
  }

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    restrict_dismissals        = true
    require_last_push_approval = true
  }
}
