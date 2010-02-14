class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end
  
  def index
  end
  
  def archive
    @events = Event.past + Event.unknown
  end
end
