class SessionsController < ApplicationController
  def connect
    url = "https://api.weibo.com/oauth2/authorize?client_id=#{Rails.application.secrets.app_key}&response_type=code&redirect_uri=#{CGI.escape Rails.application.secrets.callback_url}" 
    redirect_to url
  end

  def callback
    connection = Faraday.new
    body = {client_id: Rails.application.secrets.app_key, 
            client_secret: Rails.application.secrets.app_secret, 
            code: params[:code], 
            grant_type: "authorization_code", 
            redirect_uri: Rails.application.secrets.callback_url 
    }

    response = connection.post do |req|
      req.url "https://api.weibo.com/oauth2/access_token", body
    end

    access_token = MultiJson.decode(response.body)

    session[:uid] = access_token['uid']
    redirect_to root_url 
  end
end
