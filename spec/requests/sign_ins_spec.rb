require 'rails_helper'

RSpec.describe "Sign In", :type => :request do
  describe "GET /sign_ins" do
    it "display sign in button" do
      get "/"
      expect(response.body).to include("微博登录")
    end

    it "redircts to authorize_url when visit signin url" do
      get "/auth/connect/weibo"
      url = "https://api.weibo.com/oauth2/authorize?client_id=3824722308&response_type=code&redirect_uri=#{CGI.escape "http://ws.mytw.org:3000/auth/callback/weibo"}"
      expect(response).to redirect_to(url)
    end

    describe "callback request" do
      before(:each) do
        json =  {
          access_token: "ACCESS_TOKEN",
          expires_in: 1234,
          remind_in:"798114",
          uid:"12341234"
        }.to_json

        body = {
          client_id: Rails.application.secrets.app_key,
          client_secret: Rails.application.secrets.app_secret,
          code: "CODE",
          grant_type: "authorization_code",
          redirect_uri:  "http://ws.mytw.org:3000/auth/callback/weibo"
        }

        stub_request(:post, "https://api.weibo.com/oauth2/access_token?" + body.to_query).to_return(body: json)

        get "/auth/callback/weibo?code=CODE"
      end

      it "redircts to root page without sign in button and with uid" do
        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(response.body).not_to include("微博登录")
        expect(response.body).to include("12341234")
      end
    end
  end
end
