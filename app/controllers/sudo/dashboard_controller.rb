class Sudo::DashboardController < SuperuserController
  def index
    breadcrumbs.add t('sudo.dashboard'), sudo_path
  end
end
