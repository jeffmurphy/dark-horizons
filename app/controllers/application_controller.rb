class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_action :require_login
  before_filter :set_host

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
  def set_host
    @host = request.host
  end
end
