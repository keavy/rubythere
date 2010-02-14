class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
  end
  
  def index
    options = ['attend','speak']
    if params[:focus] && options.include?(params[:focus])
      @focus = params[:focus]
      @content_title = (@focus == 'speak') ? 'to speak at' : 'to attend'
    end
    @events = (params[:focus] == 'speak') ? Event.upcoming.open_for_speakers : Event.upcoming
  end
  
  def archive
    @events = Event.past + Event.unknown
  end
end
