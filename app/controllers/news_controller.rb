require 'open-uri'
require 'json'
require "net/https"
require "uri"

class NewsController < ApplicationController
  def index
    uri = URI(URI.encode("https://openapi.naver.com/v1/search/news.json?query=#{params[:keyword]}&display=10&start=1&sort=sim"))
    req = Net::HTTP::Get.new(uri)
    req['X-Naver-Client-Id'] = ENV["X-Naver-Client-Id"]
    req['X-Naver-Client-Secret'] = ENV["X-Naver-Client-Secret"]

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {
      |http| http.request(req)
    }

    @news = JSON.parse(res.body)

    render json: @news
  end
end
