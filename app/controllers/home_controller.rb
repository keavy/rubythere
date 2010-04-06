class HomeController < ApplicationController
  #caches_page :index
  
  def index
    @happenings = Happening.upcoming
  end
end
