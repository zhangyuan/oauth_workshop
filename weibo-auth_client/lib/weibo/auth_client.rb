require "weibo/auth_client/version"

module Weibo
  class AuthClient
    def initialize(client_id, client_secret)
      @client_id, @client_secret = client_id, client_secret 
    end

    def authorize_url(redirect_uri)
      url = "https://api.weibo.com/oauth2/authorize?client_id=#{@client_id}&response_type=code&redirect_uri=#{CGI.escape redirect_uri}" 
    end

    def get_token(code, redirect_uri)
      connection = Faraday.new
      body = {
        client_id: @client_id, 
        client_secret: @client_secret, 
        code: code, 
        grant_type: "authorization_code", 
        redirect_uri: redirect_uri
      }

      response = connection.post do |req|
        req.url "https://api.weibo.com/oauth2/access_token", body
      end

      MultiJson.decode(response.body)
    end
  end
end
