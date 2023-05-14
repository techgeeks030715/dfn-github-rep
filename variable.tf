variable "token" {}
#variable "pull_request_bypassers" {}
variable "branch_pattern"{
    type = list(string)
    default = ["planned-release-dev", "master"]
}