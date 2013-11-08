class Admin::AdminController < ApplicationController
  layout "admin"
  before_filter :authenticate

  private
  def authenticate 
    session[:return_to] ||= request.env["REQUEST_URI"]
    authenticate_user!
    redirect_to root_url, alert: "You must be an administrator to access this area." unless current_user.admin?
  end
end
