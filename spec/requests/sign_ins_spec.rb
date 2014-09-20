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
        get "/auth/callback/weibo?code=3db321504fb7cae7aca7738009666a16"
      end

      it "redircts to root page without sign in button" do
        expect(response).to redirect_to(root_url)
        follow_redirect!
        expect(response.body).not_to include("微博登录")
      end
    end
  end
end
