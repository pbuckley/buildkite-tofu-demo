terraform {
  required_providers {
    buildkite = {
      source  = "buildkite/buildkite"
      version = "~> 1.0"
    }
  }
}

variable "pipeline_name" {
  type = string
  description = "Name of the pipeline you want to create."
}

variable "pipeline_repo" {
  type = string
  description = "Full URL to the git repo associated with the pipeline."
}

# Configure the Buildkite Provider
provider "buildkite" {
  # Use the `BUILDKITE_ORGANIZATION_SLUG` environment variable if org not set here
  # organization = "demo"
  # Use the `BUILDKITE_API_TOKEN` environment variable so the token is not committed
  # api_token = "no-no-no"
}

# Add a pipeline
resource "buildkite_pipeline" "pipeline" {
  color        = "#00FF17"
  emoji        = ":control_knobs:"
  tags         = [ "demo", "tofu", "expendable", "auto" ]
  name         = var.pipeline_name
  repository   = var.pipeline_repo
  steps = <<EOT
steps:
  - label: ':pipeline: Pipeline Uploady'
    command: buildkite-agent pipeline upload .buildkite/pipeline.yml
EOT

  provider_settings = {
    build_branches      = false
    build_tags          = true
    trigger_mode        = "code"
  }
}
