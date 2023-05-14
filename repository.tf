resource "github_repository" "default" {
  for_each = local.repos

  name = each.key

  visibility             = "public"
  has_issues             = false
  has_discussions        = false
  has_projects           = false
  has_wiki               = false
  is_template            = false
  vulnerability_alerts   = true
  delete_branch_on_merge = true
}

# resource "github_branch" "development" {
#   for_each = github_repository.default

#   repository = each.value.name
#   branch     = "planned-release-dev"
# }

# resource "github_branch_default" "default" {
#   for_each = github_repository.default

#   repository = each.value.name
#   branch     = github_branch.development[each.key].branch
# }

data "github_repository_branches" "example" {
    for_each   =  github_repository.default
    repository = each.key
}

resource "github_branch_protection" "example" {
  for_each = github_repository.default

  repository_id = each.value.name
  pattern       = var.branch_pattern[0]

  required_pull_request_reviews {
    required_approving_review_count = 2
    require_code_owner_reviews      = true
    require_last_push_approval      = true
    #pull_request_bypassers = var.pull_request_bypassers
  }

 required_status_checks {
   strict   = true
   contexts = ["build-and-test-ubuntu"]
 }

 require_conversation_resolution = true
 lock_branch                     = true
}

resource "github_branch_protection" "master" {
 for_each = github_repository.default

 repository_id = each.value.name
 pattern       = var.branch_pattern[1]

 required_pull_request_reviews {
   required_approving_review_count = 2
   require_code_owner_reviews      = true
   require_last_push_approval      = true
   #pull_request_bypassers = var.pull_request_bypassers
 }

 required_status_checks {
   strict   = true
   contexts = ["build-and-test-ubuntu"]
 }

 require_conversation_resolution = true
 lock_branch                     = true
}

resource "github_repository_autolink_reference" "autolink" {
 for_each = {
   for p in setproduct([for key, repo in local.repos : key], local.jira_projects) : "${p[0]}/${p[1]}" => {
     repo = p[0]
     jira = p[1]
   }
 }

 repository          = each.value.repo
 key_prefix          = "${each.value.jira}-"
 target_url_template = "https://dataflexnet.atlassian.net/browse/${each.value.jira}-<num>"
 is_alphanumeric     = false

 depends_on = [
   github_repository.default
 ]
}
