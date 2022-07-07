class NewsController < ApplicationController
  

  def index
    require 'news-api'
    news = News.new(ENV['NEWS_API_KEY'])
    @news = news.get_everything(q: 'liverpool-fc OR football',
                                language: 'jp',
                                sortBy: 'publishedAt'
                                )
  end
end
