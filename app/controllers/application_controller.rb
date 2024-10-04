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
end
