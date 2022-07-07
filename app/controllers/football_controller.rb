class FootballController < ApplicationController
  
  before_action :key, only: %i[ranking schedule]

  def ranking; end

  def schedule; end

  private

  def key
    gon.football_info = ENV['FOOTBALL_INFO']
  end
end
