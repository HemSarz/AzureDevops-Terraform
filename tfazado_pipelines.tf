resource "azuredevops_build_definition" "DeployPipeline" {
  project_id      = "azuredevops_project.adoproj.id"
  name            = "tfaz_pipe"
  agent_pool_name = "Hosted Ubuntu 1804"

  ci_trigger {
    use_yaml = true
  }

  variable_groups = [
    azuredevops_variable_group.hawaVB.id
  ]

  repository {
    repo_type   = "TfsGit"
    repo_id     = "azuredevops_git_repository.new_repo.id"
    branch_name = "azuredevops_git_repository.new_repo.default_branch"
    yml_path    = "./BuildDefinitions/Example.yml"
  }
}