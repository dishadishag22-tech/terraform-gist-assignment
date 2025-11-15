terraform {
  required_providers {
    github = {
      source  = "hashicorp/github"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

resource "github_gist" "identity" {
  description = "Terraform assignment - identity file"
  public      = true

  files = {
    "identity.txt" = var.identity_text
  }
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "github_owner" {
  type = string
}

variable "identity_text" {
  type = string
}

output "gist_url" {
  value       = try(github_gist.identity.html_url, github_gist.identity.url)
  description = "URL of the created gist"
}
