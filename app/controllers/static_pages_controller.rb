class StaticPagesController < ApplicationController

  skip_before_action :authenticate_user, only: [:index]


  def index
    @suggestion = Suggestion.new
  end

  def help
  end

  def profile
  end
end
