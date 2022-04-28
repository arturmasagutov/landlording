# frozen_string_literal: true

# This Controller is responsible for user login
class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  include SessionsHelper

  def index
    redirect_to visitors_url if user_signed_in?
  end

  def new
    set_flash_message(:notice, :invalid)
    redirect_to root_path
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.confirmed_at.nil?
      set_flash_message(:notice, :inactive) if is_navigational_format?
      redirect_to root_path
    else
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      if session[:return_to].blank?
        redirect_to visitors_url
      else
        redirect_to root_path
        session[:return_to] = nil
      end
    end
  end

  def google_auth
    user = CreateOAuthUserService.new(auth).call
    sign_in user
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    redirect_to visitors_url
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
