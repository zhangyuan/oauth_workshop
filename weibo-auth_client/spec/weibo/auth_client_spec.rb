require "spec_helper"

describe Weibo::AuthClient do
  let(:auth_client) { Weibo::AuthClient.new(3824722308, "aca769461ad1f27b08e70f243ec557da") }

  describe "authorize_url" do
    it 'returns authorize_url' do
      expected_url = "https://api.weibo.com/oauth2/authorize?client_id=3824722308&response_type=code&redirect_uri=#{CGI.escape "http://ws.mytw.org:3000/auth/callback/weibo"}"

      expect(auth_client.authorize_url("http://ws.mytw.org:3000/auth/callback/weibo")).to eq(expected_url)
    end
  end

  describe "get token" do
    let(:access_token) do
      {
        "access_token" => "ACCESS_TOKEN",
        "expires_in" => 1234,
        "remind_in"=> "798114",
        "uid" => "12341234"
      }
    end

    before(:each) do
      body = { 
        client_id: 3824722308,
        client_secret: "aca769461ad1f27b08e70f243ec557da",
        code: "CODE",
        grant_type: "authorization_code",
        redirect_uri:  "http://ws.mytw.org:3000/auth/callback/weibo"
      } 

      stub_request(:post, "https://api.weibo.com/oauth2/access_token?client_id=3824722308&client_secret=aca769461ad1f27b08e70f243ec557da&code=CODE&grant_type=authorization_code&redirect_uri=#{CGI.escape "http://ws.mytw.org:3000/auth/callback/weibo"}").to_return(body: MultiJson.encode(access_token))
    end

    it "gets access token" do
      token = auth_client.get_token("CODE", "http://ws.mytw.org:3000/auth/callback/weibo")
      expect(token).to eq(access_token)
    end
  end
end
