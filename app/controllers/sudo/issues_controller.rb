class Sudo::IssuesController < SuperuserController
  def show
    @issue = Issue.find(params[:id])
    breadcrumbs.add t('sudo.dashboard'), sudo_path
    breadcrumbs.add @issue.project.name, sudo_project_path(@issue.project)
    breadcrumbs.add @issue.title, sudo_issue_path(@issue)
  end
end
