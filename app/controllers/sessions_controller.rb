class SessionsController < ApplicationController
  def connect
    url = "https://api.weibo.com/oauth2/authorize?client_id=#{Rails.application.secrets.app_key}&response_type=code&redirect_uri=#{CGI.escape Rails.application.secrets.callback_url}" 
    redirect_to url
  end

  def callback
    redirect_to root_url 
  end
end
