class Sudo::DashboardController < ApplicationController
  def index
    breadcrumbs.add t('sudo.dashboard'), sudo_path
  end
end
