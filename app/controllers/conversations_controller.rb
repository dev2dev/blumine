class ConversationsController < ApplicationController
  before_filter :find_project

  def index
    @conversations = @project.conversations.order('created_at DESC').limit(10)
    @conversation = @project.conversations.new
  end

  def create
    @conversation = @project.conversations.build(params[:conversation])
    @conversation.user = current_user

    respond_to do |f|
      if @conversation.save
        # Send Notifications
        regex = /@[a-zA-Z0-9._-]+/
        names = @conversation.replies.first.content.scan(regex)
        names.each do |name|
          user = User.find_by_name(name[1..name.size])
          NotificationMailer.notify_user(user, @conversation).deliver if user
        end
        f.html { render 'create.html.haml', :layout => false }
        f.js
      else
        f.html { redirect_to @project, :error => 'save failed' }
        f.js { render :text => :error, :status => 500 }
      end
    end
  end

  private
    def find_project
      @project = Project.find(params[:project_id])
    end
end
