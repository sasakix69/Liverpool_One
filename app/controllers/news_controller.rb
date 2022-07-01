class NewsController < ApplicationController
  def index
  end

  def data
    uri = URI.parse('https://newsapi.org/v2/everything?q=liverpool&language=jp&sortBy=publishedAt&apiKey=e49127864c4a4fd78bea651073275fc5')
    json = Net::HTTP.get(uri)
    moments = JSON.parse(json)
    @data = moments['articles'].to_json
  end
end
