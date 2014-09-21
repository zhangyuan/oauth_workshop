class SessionsController < ApplicationController
  def connect
    redirect_to auth_client.authorize_url(Rails.application.secrets.callback_url)
  end

  def callback
    access_token = auth_client.get_token(params[:code], Rails.application.secrets.callback_url)
    session[:uid] = access_token['uid']
    redirect_to root_url 
  end

  private
  def auth_client
    Weibo::AuthClient.new(Rails.application.secrets.app_key, Rails.application.secrets.app_secret)
  end
end


