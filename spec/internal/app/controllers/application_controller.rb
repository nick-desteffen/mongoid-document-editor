class ApplicationController < ActionController::Base

private

  def set_user(user)
    @user = user
  end

  def require_admin
    redirect_to "/" if @user.nil? || !@user.admin?
  end

end
