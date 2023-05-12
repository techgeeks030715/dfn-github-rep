terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.token
  owner = "Dataflexnet"
}

locals {
  repos = {
    aws-secrets-manager-extensions = {}
    dfn-authentication             = {}
    dfn-core                       = {}
    dfn-dataaccess                 = {}
    dfn-deploy                     = {}
    dfn-flexid-client              = {}
    dfn-logging-awscloudwatch      = {}
    dfn-stylecop                   = {}
    dfn-tracing                    = {}
    submitters-core                = {}
    dfn-lb-health                  = {}
    dfn-fontawesome                = {}
  }

  jira_projects = [
    "DRY",
    "SUB",
  ]
}
