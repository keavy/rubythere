class HomeController < ApplicationController
  def index
    @happenings = Happening.upcoming
  end
end
