class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ActionPolicy::Controller

  before_action :authenticate_user!
  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  private

  def complain(message: "You are not authorized to acces this page")
    redirect_to root_path, alert: message
  end
end
