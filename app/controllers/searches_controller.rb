class SearchesController < ApplicationController
  def show
    if params[:q]
      @events = Event.search params[:q], :conditions => {:approved => true}
    end
  end
end
