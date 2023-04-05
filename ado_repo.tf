resource "azuredevops_git_repository" "new_repo" {
  project_id = "azuredevops_project.adoproj.id"
  name       = "TfazRepo"
  initialization {
    init_type = "Clean"
  }
}