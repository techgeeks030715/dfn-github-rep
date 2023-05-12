resource "github_team" "developers" {
  name        = "Developers"
  description = "All developers"
  privacy     = "closed"
}

resource "github_team" "submitters" {
  name           = "Submitters"
  description    = "Submitters"
  privacy        = "closed"
  parent_team_id = github_team.developers.id
}

resource "github_team" "id" {
  name           = "Flex ID"
  description    = "Flex ID"
  privacy        = "closed"
  parent_team_id = github_team.developers.id
}

resource "github_team" "vc" {
  name           = "Virtual Card"
  description    = "Virtual Card"
  privacy        = "closed"
  parent_team_id = github_team.developers.id
}

resource "github_team" "ops" {
  name        = "Ops"
  description = "Operations"
  privacy     = "closed"
}

resource "github_team" "qa" {
  name        = "QA"
  description = "QA"
  privacy     = "closed"
}
