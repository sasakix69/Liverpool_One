# frozen_string_literal: true

class TopController < ApplicationController
  before_action :sign_in_required, only: [:show]

  def index; end

  def show
    render layout: 'application'
  end
end
