oauth_workshop
====================

## 内容

1. 用TDD的方式，使用OAuth协议，完成”通过微博登录“的功能。测试框架使用 rspec 。
2. 将 OAuth 客户端提取成 gem。

## 准备工作

1. 安装好Ruby环境(ruby版本为1.9.3以上) 及 bundler 
2. 下载代码：`git clone https://github.com/zhangyuan/oauth_workshop`
3. 安装必要的 gem，在项目根目录执行： `bundle install`
4. 修改本机 hosts ，将 `ws.mytw.org` 指向本机，即 `127.0.0.1`

## 工具

### multi_json

* <https://github.com/intridea/multi_json>
* A generic swappable back-end for JSON handling.

用法

```
> json = MultiJson.encode(name: "yuan")
=> "{\"name\":\"yuan\"}"
> MultiJson.decode(json)
=> {"name"=>"yuan"}
```

### webmock

* <https://github.com/bblimke/webmock>
* Library for stubbing and setting expectations on HTTP requests in Ruby.

### faraday

* <https://github.com/lostisland/faraday>
* Simple, but flexible HTTP client library, with support for multiple backends.

用法

```ruby
connection = Faraday.new
response = connection.post do |req|
  req.url "https://api.weibo.com/oauth2/access_token", client_id: "1234", client_secret: "abcd", grant_type: "authorization_code", code: "thecode", redirect_uri: "http://ws.mytw.org:3000/auth/callback/weibo"
end

access_token = MultiJson.decode(response.body)

```

## 链接

## OAuth

1. 微博开放平台 <http://open.weibo.com/>
2. 微博APIO Auth 2.0授权接口 <http://open.weibo.com/wiki/%E5%BE%AE%E5%8D%9AAPI#OAuth2>
3. 微博授权机制说明 <http://open.weibo.com/wiki/%E6%8E%88%E6%9D%83%E6%9C%BA%E5%88%B6%E8%AF%B4%E6%98%8E>
4. 小议OAuth 2.0的state参数——从开发角度也说《互联网最大规模帐号劫持漏洞即将引爆》 <http://zone.wooyun.org/content/1562>

## Rspec

1. Controller specs <https://www.relishapp.com/rspec/rspec-rails/docs/controller-specs>

## Bundler

1. Railscasts: New Gem with Bundler <http://railscasts.com/episodes/245-new-gem-with-bundler>
2. Building Gem With Bundler <http://no-fucking-idea.com/blog/2012/04/11/building-gem-with-bundler/>
