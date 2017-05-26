class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  private
  def handle_not_found
    flash[:error] = t "not_found"
    redirect_to root_path
  end
end
