class Sudo::UsersController < ApplicationController
  layout 'sudo'

  before_filter :must_login_first
  before_filter :root_required

  def index
    @users = User.order('created_at DESC').page(params[:page])
    breadcrumbs.add t('sudo.dashboard'), sudo_path
    breadcrumbs.add t('sudo.manage_user'), sudo_users_path
  end

  def destroy
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to sudo_users_path, :success => success_do(:delete_user) }
        format.js
      else
        format.html { redirect_to sudo_users_path, :notice => failed(:delete_user) }
        format.js { render :text => :error, :status => 500 }
      end
    end
  end
end
