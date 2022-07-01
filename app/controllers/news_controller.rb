class NewsController < ApplicationController

  def index
    require 'news-api'
    news = News.new(ENV['NEWS_API_KEY'])
    @news = news.get_everything(q: 'football',
                                      language: 'jp',
                                      sortBy: 'publishedAt')
  end
end
