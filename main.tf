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
  color        = "#7bda68"
  emoji        = ":clapper:"
  tags         = [ "demo", "tofu", "expendable", "auto" ]
  cluster_id   = "Q2x1c3Rlci0tLWFkODYwNDVhLWJkN2YtNGRjNy04YmI1LTJiMWY2M2JiZjU1NQ=="
  name         = var.pipeline_name
  repository   = var.pipeline_repo
  steps        = file("${path.module}/pipeline.yml")

  provider_settings = {
    build_branches      = false
    build_tags          = true
    trigger_mode        = "code"
  }
}
