class HomeController < ApplicationController
  def index
    @events = Event.all
  end
end
