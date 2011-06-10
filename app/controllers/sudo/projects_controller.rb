class Sudo::ProjectsController < SuperuserController
  def show
    @project = Project.find(params[:id])
    breadcrumbs.add t('sudo.dashboard'), sudo_path
    breadcrumbs.add @project.name, project_path(@project)
  end
end
